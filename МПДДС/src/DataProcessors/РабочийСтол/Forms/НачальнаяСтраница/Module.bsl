
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УтановитьЗначенияПоУмолчанию();
	
	ОбновитьНаСервере();
	
КонецПроцедуры // ПриСозданииНаСервере()

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Настройки(Команда)
	
	Оповещение = Новый ОписаниеОповещения("НастройкиЗавершение", ЭтотОбъект);
	ОткрытьФорму("Обработка.РабочийСтол.Форма.ОтборыИсторияПлатежей", ОтборыИсторияПлатежей, ЭтаФорма,,,,Оповещение);
	
КонецПроцедуры // Настройки()

&НаКлиенте
Процедура Обновить(Команда)
	
	ОбновитьНаСервере();
	
КонецПроцедуры // Обновить()

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ВыборПлатежиСчетаПриИзменении(Элемент)
	
	Элементы.ГруппаСтраницыСчетаПлатежи.ТекущаяСтраница = Элементы["Группа" + ВыборПлатежиСчета];
	
КонецПроцедуры // ВыборПлатежиСчетаПриИзменении()

#КонецОбласти

#Область ОбработчикиСобытийТаблицФормы

&НаКлиенте
Процедура СчетаКомпанииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекущаяСтрока = Элементы.СчетаКомпании.ТекущиеДанные;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("БанковскийСчет", ТекущаяСтрока.БанковскийСчет);
	ПараметрыФормы.Вставить("Сумма"			, ТекущаяСтрока.Сумма);
	
	ОткрытьФорму("Обработка.РабочийСтол.Форма.РасшифровкаСчета", ПараметрыФормы);
	
КонецПроцедуры // СчетаКомпанииВыбор()

&НаКлиенте
Процедура ПлатежиВсеВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	РасшифровкаПлатежа(Элемент);
	
КонецПроцедуры // ПлатежиВсеВыбор()

&НаКлиенте
Процедура ПлатежиВходящиеВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	РасшифровкаПлатежа(Элемент);
	
КонецПроцедуры // ПлатежиВходящиеВыбор()

&НаКлиенте
Процедура ПлатежиИсходящиеВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	РасшифровкаПлатежа(Элемент);
	
КонецПроцедуры // ПлатежиИсходящиеВыбор()

#КонецОбласти

#Область ПроцедурыИФункцииОбщегоНазначения

&НаСервере
Процедура НастройкиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ОтборыИсторияПлатежей, Результат);
	
	Элементы.НадписьПериод.Заголовок = ОбщегоНазначения.ПредставлениеПериодаРасчетногоДокумента(
		ОтборыИсторияПлатежей.ДатаНачала, ОтборыИсторияПлатежей.ДатаОкончания);
	
	ОбновитьНаСервере();
	
КонецПроцедуры // НастройкиЗавершение()

&НаСервере
Процедура УтановитьЗначенияПоУмолчанию()
	
	ВыборПлатежиСчета = "ДоступноСредств";
	
	ОтборыИсторияПлатежей = Новый Структура;
	ОтборыИсторияПлатежей.Вставить("РазделУчета"	 , Перечисления.РазделУчета.ПустаяСсылка());
	ОтборыИсторияПлатежей.Вставить("Организация"	 , Справочники.Организации.ПустаяСсылка());
	ОтборыИсторияПлатежей.Вставить("Контрагент"		 , Справочники.Контрагенты.ПустаяСсылка());
	ОтборыИсторияПлатежей.Вставить("БанковскийСчет"	 , Справочники.БанковскиеСчета.ПустаяСсылка());
	ОтборыИсторияПлатежей.Вставить("ДатаНачала"		 , ДобавитьМесяц(НачалоДня(ТекущаяДата()), -1));
	ОтборыИсторияПлатежей.Вставить("ДатаОкончания"	 , КонецДня(ТекущаяДата()));
	ОтборыИсторияПлатежей.Вставить("СуммаОт"		 , 0);
	ОтборыИсторияПлатежей.Вставить("СуммаДо"		 , 0);
	ОтборыИсторияПлатежей.Вставить("РасшифровкаСчета", Ложь);
	
	Элементы.НадписьПериод.Заголовок = ОбщегоНазначения.ПредставлениеПериодаРасчетногоДокумента(
		ОтборыИсторияПлатежей.ДатаНачала, ОтборыИсторияПлатежей.ДатаОкончания);
	
КонецПроцедуры // УтановитьЗначенияПоУмолчанию()

&НаКлиенте
Процедура РасшифровкаПлатежа(Элемент)
	
	ТекущаяСтрока = Элемент.ТекущиеДанные;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("БанковскийСчет"	, ТекущаяСтрока.БанковскийСчет);
	ПараметрыФормы.Вставить("Организация"		, ТекущаяСтрока.Организация);
	ПараметрыФормы.Вставить("Контрагент"		, ТекущаяСтрока.Контрагент);
	ПараметрыФормы.Вставить("ДатаПлатежа"		, ТекущаяСтрока.ДатаПлатежа);
	ПараметрыФормы.Вставить("НомерПлатежа"		, ТекущаяСтрока.НомерПлатежа);
	ПараметрыФормы.Вставить("НазначениеПлатежа"	, ТекущаяСтрока.НазначениеПлатежа);
	ПараметрыФормы.Вставить("Сумма"				, ТекущаяСтрока.Сумма);
	ПараметрыФормы.Вставить("Приход"			, ТекущаяСтрока.Приход);
	
	ОткрытьФорму("Обработка.РабочийСтол.Форма.РасшифровкаПлатежа", ПараметрыФормы);
	
КонецПроцедуры // РасшифровкаПлатежа()

&НаСервере
Процедура ОбновитьНаСервере()
	
	Если Не ОбщегоНазначенияВызовСервера.ПолучитьЗначениеКонстанты("СоединениеСЦБУстановлено") Тогда
		Возврат;
	КонецЕсли;
	
	Ответ = ОбменМобильноеПриложениеСервер.СинхронизацияУзловЗавершена();
	Если Не Ответ.Успешно Тогда
		Возврат;
	КонецЕсли;
	
	Объект.СуммыВВалютах.Очистить();
	Объект.СчетаКомпании.Очистить();
	Объект.ПлатежиВсе.Очистить();
	Объект.ПлатежиВходящие.Очистить();
	Объект.ПлатежиИсходящие.Очистить();
	
	СтруктураДанных = ОбменМобильноеПриложениеСервер.ПолучитьДанные(ОтборыИсторияПлатежей);
	
	Если СтруктураДанных.Обороты <> Неопределено Тогда
		
		Объект.ПлатежиВсе.Загрузить(СтруктураДанных.Обороты.ВсеПлаттежи);
		Объект.ПлатежиВходящие.Загрузить(СтруктураДанных.Обороты.Входящие);
		Объект.ПлатежиИсходящие.Загрузить(СтруктураДанных.Обороты.Исходящие);
		
	КонецЕсли;
	
	Если СтруктураДанных.Остатки <> Неопределено Тогда
		
		Объект.СчетаКомпании.Загрузить(СтруктураДанных.Остатки.СчетаКомпании);
		
		Для Каждого Строка Из СтруктураДанных.Остатки.СуммыВВалютах Цикл
			
			НоваяСтрока = Объект.СуммыВВалютах.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
			
			Попытка
				НоваяСтрока.Картинка = БиблиотекаКартинок["Money" + НоваяСтрока.Валюта.Наименование + "_Color"];
			Исключение
			КонецПопытки;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры // ОбновитьНаСервере()

#КонецОбласти