Процедура ПриНачалеРаботыСистемы()
	
	Если ОбщегоНазначенияВызовСервера.ПолучитьЗначениеКонстанты("КодДоступаВПриложение") <> "" Тогда
		Результат = ОткрытьФормуМодально("ОбщаяФорма.ВводКодаДоступаВПриложение");
		Если Результат = Неопределено ИЛИ НЕ Результат Тогда
			ЗавершитьРаботуСистемы(Ложь);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры