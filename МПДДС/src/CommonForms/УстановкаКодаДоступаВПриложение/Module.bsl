#Область ВспомогательныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьКодДоступа()
	
	УстановитьКодДоступаСкрытый();
	Элементы.ДекорацияОшибка.Заголовок = "";
	Если ТекущийШаг = "ВводТекущегоКодаДоступа" Тогда
		Если КодДоступаСтарый = ВводимыйКодДоступа Тогда
			ТекущийШаг = "ВводНовогоКодаДоступа";
			УстановитьЗаголовокПоляВвода();
			ВводимыйКодДоступа = "";
			УстановитьКодДоступаСкрытый();
		ИначеЕсли СтрДлина(ВводимыйКодДоступа) = 4 Тогда
			Элементы.ДекорацияОшибка.Заголовок = НСтр("ru='Неверный код доступа!';en='Invalid access code!'");
			ПодключитьОбработчикОжидания("Подключаемый_ОчиститьКодДоступа", 0.5, Истина);
		КонецЕсли;
	ИначеЕсли ТекущийШаг = "ВводКодаДоступа" ИЛИ ТекущийШаг = "ВводНовогоКодаДоступа" Тогда
		Если СтрДлина(ВводимыйКодДоступа) = 4 Тогда
			КодДоступа = ВводимыйКодДоступа;
			ТекущийШаг = "ВводПовторноКодаДоступа";
			УстановитьЗаголовокПоляВвода();
			ВводимыйКодДоступа = "";
			УстановитьКодДоступаСкрытый();
		КонецЕсли;
	ИначеЕсли ТекущийШаг = "ВводПовторноКодаДоступа" Тогда
		Если КодДоступа = ВводимыйКодДоступа Тогда
			ОбщегоНазначенияВызовСервера.УстановитьЗначениеКонстанты("КодДоступаВПриложение", ВводимыйКодДоступа);
			Закрыть(Истина);
		ИначеЕсли СтрДлина(ВводимыйКодДоступа) = 4 Тогда
			Элементы.ДекорацияОшибка.Заголовок = НСтр("ru='Коды доступа отличаются!';en='Access codes are!'");
			Если ЗначениеЗаполнено(КодДоступаСтарый) Тогда
				ТекущийШаг = "ВводНовогоКодаДоступа";
			Иначе
				ТекущийШаг = "ВводКодаДоступа";
			КонецЕсли;
			УстановитьЗаголовокПоляВвода();
			ПодключитьОбработчикОжидания("Подключаемый_ОчиститьКодДоступа", 0.5, Истина);
		КонецЕсли;
	КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКодДоступаСкрытый()
	
	ДлинаКодаДоступа = СтрДлина(ВводимыйКодДоступа);
	
	КодДоступаСкрытый = "○○○○";
	
	Если ДлинаКодаДоступа = 0 Тогда
		КодДоступаСкрытый = "○○○○";
	ИначеЕсли ДлинаКодаДоступа = 1 Тогда
		КодДоступаСкрытый = "●○○○";
	ИначеЕсли ДлинаКодаДоступа = 2 Тогда
		КодДоступаСкрытый = "●●○○";
	ИначеЕсли ДлинаКодаДоступа = 3 Тогда
		КодДоступаСкрытый = "●●●○";
	ИначеЕсли ДлинаКодаДоступа = 4 Тогда
		КодДоступаСкрытый = "●●●●";
	КонецЕсли;
	
	Элементы.ДекорацияКодДоступа.Заголовок = КодДоступаСкрытый;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОчиститьКодДоступа()
	
	ВводимыйКодДоступа = "";
	УстановитьКодДоступаСкрытый();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовокПоляВвода()
	
	Если ТекущийШаг = "ВводТекущегоКодаДоступа" Тогда
		Элементы.ДекорацияЗаголовок.Заголовок = НСтр("ru='ВВЕДИТЕ ТЕКУЩИЙ КОД ДОСТУПА';en='ENTER THE CURRENT CODE ACCESS'");
	ИначеЕсли ТекущийШаг = "ВводКодаДоступа" Тогда
		Элементы.ДекорацияЗаголовок.Заголовок = НСтр("ru='ПРИДУМАЙТЕ КОД ДОСТУПА';en='ENTER ACCESS CODE'");
	ИначеЕсли ТекущийШаг = "ВводНовогоКодаДоступа" Тогда
		Элементы.ДекорацияЗаголовок.Заголовок = НСтр("ru='ПРИДУМАЙТЕ НОВЫЙ КОД ДОСТУПА';en='ENTER ACCESS CODE'");
	ИначеЕсли ТекущийШаг = "ВводПовторноКодаДоступа" Тогда
		Элементы.ДекорацияЗаголовок.Заголовок = НСтр("ru='ПОВТОРИТЕ КОД ДОСТУПА';en='REPEAT ACCESS CODE'");
	КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область ДействияКомандныхПанелейФормы

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КодДоступа = Константы.КодДоступаВПриложение.Получить();
	КодДоступаСтарый = КодДоступа;
	
	Если ЗначениеЗаполнено(КодДоступаСтарый) Тогда
		ТекущийШаг = "ВводТекущегоКодаДоступа";
	Иначе
		ТекущийШаг = "ВводКодаДоступа";
	КонецЕсли;
	
	УстановитьЗаголовокПоляВвода();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьКодДоступаСкрытый();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка1Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "1";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка2Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "2";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка3Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "3";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка4Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "4";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка5Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "5";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка6Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "6";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка7Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "7";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка8Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "8";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка9Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "9";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаОтменаНажатие(Элемент)
	
	Закрыть(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура Кнопка0Нажатие(Элемент)
	
	ВводимыйКодДоступа = ВводимыйКодДоступа + "0";
	ПроверитьКодДоступа();
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаУдалитьНажатие(Элемент)
	
	ДлинаВводимыйКодДоступаа = СтрДлина(ВводимыйКодДоступа);
	ВводимыйКодДоступа = Лев(ВводимыйКодДоступа, ДлинаВводимыйКодДоступаа - 1);
	ПроверитьКодДоступа();
	
КонецПроцедуры

#КонецОбласти