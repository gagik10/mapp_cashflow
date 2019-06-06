#Область СлужебныйПрограммныйИнтерфейс

// Получает значение константы по имени.
//
Функция ПолучитьЗначениеКонстанты(ИмяКонстанты) Экспорт
	
	Возврат Константы[ИмяКонстанты].Получить();
	
КонецФункции // ПолучитьЗначениеКонстанты()

// Устанавливает значение константы по имени.
//
Процедура УстановитьЗначениеКонстанты(ИмяКонстанты, Значение) Экспорт
	
	Константы[ИмяКонстанты].Установить(Значение);
	
Конецпроцедуры

// Возвращает имя значения перечисления из метаданных
//
Функция ПолучитьИмяЗначенияПеречисления(ИмяПеречисления, Значение) Экспорт
	
	Имя = "";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Значение", Значение);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РазделУчета.Порядок КАК Порядок
	|ИЗ
	|	Перечисление.РазделУчета КАК РазделУчета
	|ГДЕ
	|	РазделУчета.Ссылка = &Значение";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РазделУчета", ИмяПеречисления);
	
	Результат = Запрос.Выполнить();
	
	Если Не Результат.Пустой() Тогда
		
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Порядок = Выборка.Порядок;
		
		Имя = Метаданные.Перечисления.РазделУчета.ЗначенияПеречисления.Получить(Порядок).Имя;
		
	КонецЕсли;
	
	Возврат Имя;
	
КонецФункции // ПолучитьИмяЗначенияПеречисления()

// Устанавливает параметры сеанса.
//
Процедура УстановитьПараметрыСеанса() Экспорт
	
	СисИнфо = Новый СистемнаяИнформация;
	ПараметрыСеанса.ВерсияОС = ?(Найти(СисИнфо.ВерсияОС, "pple") > 0, "iOS", "Linux");
	
КонецПроцедуры // УстановитьПараметрыСеанса()

#КонецОбласти

#Область ПроцедурыиФункцииОбщегоНазначения

// Возвращает значение параметра сеанса "ВерсияОС".
//
// Возвращаемое значение:
// Строка
//
Функция ВерсияОС() Экспорт
	
	Возврат ПараметрыСеанса.ВерсияОС;
	
КонецФункции // ВерсияОС()

#КонецОбласти