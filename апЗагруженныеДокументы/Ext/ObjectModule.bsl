﻿Перем ВыбАгент Экспорт;
Перем Имена;
Перем КоличествоПопыток;   	     // количество попыток для проведения операции создания или записи объекта
Перем ПаузаМеждуПопытками; 		 // пауза в секундах между попытками    

#Если Клиент Тогда

Функция ПроверкаДаты(НужнаяДата, ИмяПоля) Экспорт
	
	Если НужнаяДата > '39991231235959' Тогда		
		ОбщегоНазначения.СообщитьОбОшибке(НСтр("ru='Неверно задана дата в поле " + ИмяПоля + "!'"));
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ, СКОПИРОВАННЫЕ ИЗ МОДУЛЯ ОБМЕНА ДАННЫМИ //////////////////

Функция ПолучитьСсылкуСвойствоОбъектаАгентПлюс(_ИмяСвойстваОбъекта) Экспорт
	
	СсылкаСвойствоОбъекта = ПланыВидовХарактеристик.СвойстваОбъектов.ПолучитьСсылку(Имена["ИдентификаторСвойстваОбъекта_" + _ИмяСвойстваОбъекта]);

	ОбъектСвойствоОбъекта = СсылкаСвойствоОбъекта.ПолучитьОбъект();
	
	Если ОбъектСвойствоОбъекта = Неопределено Тогда
		ОбъектСвойствоОбъекта = ПланыВидовХарактеристик.СвойстваОбъектов.СоздатьЭлемент();
		ОбъектСвойствоОбъекта.УстановитьСсылкуНового(СсылкаСвойствоОбъекта);
		ОбъектСвойствоОбъекта.НазначениеСвойства = Имена["НазначениеСвойства_" + _ИмяСвойстваОбъекта];
		ОбъектСвойствоОбъекта.Наименование = Имена["СвойствоОбъекта_" + _ИмяСвойстваОбъекта];		
		ОбъектСвойствоОбъекта.ТипЗначения = Имена["ТипЗначения_" + _ИмяСвойстваОбъекта];		
		Попытка
			ОбъектСвойствоОбъекта.Записать();
		Исключение
			Инфо = ИнформацияОбОшибке();
			ОповеститьОСобытии(Инфо.Описание, СтатусСообщения.Внимание);
			Возврат Неопределено;
		КонецПопытки;
		ОповеститьОСобытии("ru='Добавлен элемент """ + ОбъектСвойствоОбъекта.Наименование + """ (план видов характеристик """ + ОбъектСвойствоОбъекта.Метаданные().Представление() + """)'");
		
	ИначеЕсли ОбъектСвойствоОбъекта.Наименование <> Имена["СвойствоОбъекта_" + _ИмяСвойстваОбъекта] Тогда
		ОбъектСвойствоОбъекта.Наименование = Имена["СвойствоОбъекта_" + _ИмяСвойстваОбъекта];
		Попытка
			ОбъектСвойствоОбъекта.Записать();
		Исключение
			ОповеститьОСобытии("ru='" + ОписаниеОшибки() + "'", СтатусСообщения.Внимание);
			Возврат Неопределено;
		КонецПопытки;		
		
		ОповеститьОСобытии("ru='Изменен элемент """ + ОбъектСвойствоОбъекта.Наименование + """ (план видов характеристик """ + ОбъектСвойствоОбъекта.Метаданные().Представление() + """)'");
	КонецЕсли;
	
	Возврат ОбъектСвойствоОбъекта.Ссылка;
	
КонецФункции

Функция ПолучитьСсылкуКатегорияОбъектаАгентПлюс(_ИмяКатегорияОбъекта) Экспорт
	
	СсылкаКатегорияОбъекта = Справочники.КатегорииОбъектов.ПолучитьСсылку(Имена["ИдентификаторКатегорияОбъекта_" + _ИмяКатегорияОбъекта]);

	ОбъектКатегорияОбъекта = СсылкаКатегорияОбъекта.ПолучитьОбъект();
	
	Если ОбъектКатегорияОбъекта = Неопределено Тогда
		
		ОбъектКатегорияОбъекта = Справочники.КатегорииОбъектов.СоздатьЭлемент();
		ОбъектКатегорияОбъекта.УстановитьСсылкуНового(СсылкаКатегорияОбъекта);
		ОбъектКатегорияОбъекта.НазначениеКатегории = Имена["НазначениеКатегории_" + _ИмяКатегорияОбъекта];
		ОбъектКатегорияОбъекта.Наименование = Имена["КатегорияОбъекта_" + _ИмяКатегорияОбъекта];		
		
		ВыполнитьОперациюДляОбъекта(ОбъектКатегорияОбъекта, "запись"); 							
		
	ИначеЕсли ОбъектКатегорияОбъекта.Наименование <> Имена["КатегорияОбъекта_" + _ИмяКатегорияОбъекта] Тогда
		
		ОбъектКатегорияОбъекта.Наименование = Имена["КатегорияОбъекта_" + _ИмяКатегорияОбъекта];		
		ВыполнитьОперациюДляОбъекта(ОбъектКатегорияОбъекта, "запись");
		
	КонецЕсли;
	
	Возврат ОбъектКатегорияОбъекта.Ссылка;
	
КонецФункции

// Функция выполняет укзанную операцию с переданным объектом (!) или менеджером записи регистра
// и возвращает значение типа Булево в результате выполнения
// операции
//
Функция ВыполнитьОперациюДляОбъекта(Объект, ВидОперации, Агент = Неопределено) Экспорт
	
	флОперацияВыполнена = Ложь;	
		
	Для Сч = 1 По КоличествоПопыток Цикл
		
		Попытка
			
			типЗнач = ТипЗнч(Объект);
			Если ВидОперации = "запись" Тогда				
								
                флСпр = (Найти(Строка(типЗнач), "Справочник") > 0);
				флДок = (Найти(Строка(типЗнач), "Документ") > 0);								
				
				Если флСпр Или флДок Тогда
					этоНовый = Объект.ЭтоНовый();
				КонецЕсли;
				
				Объект.Записать();
				
				Если флСпр Тогда
					стр = ?(этоНовый, "Записан", "Перезаписан");					
					ТекстСообщения = "ru='" + стр + " элемент """  + Объект + """ (справочник """ + Объект.Метаданные().Представление() + """)'";				
				ИначеЕсли флДок Тогда
					стр = ?(этоНовый, "Записан", "Перезаписан");
					ТекстСообщения = "ru='" + стр + " документ """ + Объект + """ (""" + Объект.Метаданные().Представление() + """)'";	
				ИначеЕсли Найти(Строка(типЗнач), "Регистр") > 0 Тогда
					ТекстСообщения = "ru='Создана запись """ + Объект + """'";
				Иначе
					ТекстСообщения = "ru='Записан объект """ + Объект + """'";
				КонецЕсли;
				
				ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.БезСтатуса);

			ИначеЕсли ВидОперации = "проведение" Тогда
				Объект.Записать(РежимЗаписиДокумента.Проведение);
				ТекстСообщения = "ru='Проведен документ """ + Объект + """ (""" + Объект.Метаданные().Представление() + """)'";				
				ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.БезСтатуса);
			ИначеЕсли ВидОперации = "создание" Тогда
				Если Найти(Строка(типЗнач), "Справочник") > 0 Тогда
					Объект = Объект.СоздатьЭлемент();
				ИначеЕсли Найти(Строка(типЗнач), "Документ") > 0 Тогда
					Объект = Объект.СоздатьДокумент();
				Иначе
					ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.Внимание);
					Возврат Ложь;
				КонецЕсли;
			ИначеЕсли ВидОперации = "удаление" Тогда
				
				представлениеОбъекта = Строка(Объект);
				
				Если Найти(Строка(типЗнач), "Справочник") > 0 Тогда
					представление = Объект.Метаданные().Представление();
					Объект.Удалить();
					ТекстСообщения = "ru='Удален элемент """ + представлениеОбъекта + """ (справочник """ + представление + """)'";				
				ИначеЕсли Найти(Строка(типЗнач), "Документ") > 0 Тогда
					представление = Объект.Метаданные().Представление();
					Объект.Удалить();
					ТекстСообщения = "ru='Удален документ """ + представлениеОбъекта + """ (""" + представление + """)'";	
				ИначеЕсли Найти(Строка(типЗнач), "Регистр") > 0 Тогда
					Объект.Удалить();
					ТекстСообщения = "ru='Удалена запись """ + представлениеОбъекта + """'";
				КонецЕсли;
				
				ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.БезСтатуса);
				
			ИначеЕсли  ВидОперации = "пометитьНаУдаление" Тогда
				
				Если Найти(Строка(типЗнач), "Справочник") > 0 Тогда
					Объект.УстановитьПометкуУдаления(Истина);
					ТекстСообщения = "ru='Элемент """ + Объект + """ помечен на удаление (справочник """ + Объект.Метаданные().Представление() + """)'";				
				ИначеЕсли Найти(Строка(типЗнач), "Документ") > 0 Тогда
					Объект.УстановитьПометкуУдаления(Истина);
					ТекстСообщения = "ru='Документ """ + представлениеОбъекта + """ помечен на удаление (""" + Объект.Метаданные().Представление() + """)'";
				КонецЕсли;
				
				ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.БезСтатуса);
			КонецЕсли;
			
			флОперацияВыполнена = Истина;			
			
			Прервать;
			
		Исключение
			
			Сообщить("------------------------------------------------------" + Символы.ПС + ОписаниеОшибки());
			
			// Пауза снизит нагрузку на сервер и позволит другим пользователям закончить операции,
			// которые идут в транзакции.
			#Если Клиент Тогда
			Предупреждение(НСтр("ru='В данный момент нет возможности выполнить " + ВидОперации + " для объекта: " + Строка(Объект) +
							Символы.ПС + "Повторная попытка будет произведена через " + ПаузаМеждуПопытками + " секунд'"),
							ПаузаМеждуПопытками, "Пауза"); 
			#КонецЕсли
			
			ТекстСообщения = "ru='Не удалось выполнить " + ВидОперации + " для объекта: """ + Строка(Объект) + """'";
			
			ОповеститьОСобытии(ТекстСообщения, СтатусСообщения.Важное);
			
		КонецПопытки; 
		
	КонецЦикла;        		
		
	Возврат флОперацияВыполнена;
			
КонецФункции //ВыполнитьОперациюДляОбъекта()

// Функция убирает из текста сообщения слущебную информацию
//
// Параметры
//  ТекстСообщения, Строка, исходный текст сообщения//
// Возвращаемое значение:
//   Строка
//
Функция СформироватьТекстСообщения(Знач ТекстСообщения) Экспорт

	НачалоСлужебногоСообщения    = Найти(ТекстСообщения, "{");
	ОкончаниеСлужебногоСообщения = Найти(ТекстСообщения, "}:");
	
	Если ОкончаниеСлужебногоСообщения > 0 
		И НачалоСлужебногоСообщения > 0 
		И НачалоСлужебногоСообщения < ОкончаниеСлужебногоСообщения Тогда
		
		ТекстСообщения = Лев(ТекстСообщения, (НачалоСлужебногоСообщения - 1)) +
		                 Сред(ТекстСообщения, (ОкончаниеСлужебногоСообщения + 2));
						 
	КонецЕсли;
	
	Возврат СокрЛП(ТекстСообщения);

КонецФункции // СформироватьТекстСообщения()

// Выводит сообщение об ошибке
// В случае работы на клиенте или на сервере выводит в окно сообщений,
// в случае внешнего соединения вызывает исключение.
//
// Параметры:
//  ТекстСообщения - строка, текст сообщения.//
Процедура СообщитьОСобытии(ТекстСообщения, Заголовок = "", Статус = Неопределено) Экспорт

	ТекстСообщения = СформироватьТекстСообщения(ТекстСообщения);
	
	#Если НЕ ВнешнееСоединение Тогда
				
		Если ЗначениеЗаполнено(Заголовок) Тогда
			Сообщить(Заголовок);
			Заголовок = "";
		КонецЕсли;
		
		Если Статус = Неопределено Тогда
			Статус = СтатусСообщения.Обычное;
		КонецЕсли;
		Сообщить(Строка(ТекущаяДата()) + " - " + ТекстСообщения, Статус);
		
	#КонецЕсли
	
КонецПроцедуры // СообщитьОСобытии()

// Процедура предназначена для оповещения пользователей о событиях обмена
// а также для записи событий в лог обмена
//
Процедура ОповеститьОСобытии(ТекстСообщения, Статус = "") Экспорт
	
	НужныйСтатус = ?(Статус = "", СтатусСообщения.Обычное, Статус);
	
	нстрТекстСообщения = НСтр(ТекстСообщения);
	#Если Клиент Тогда
		СообщитьОСобытии(нстрТекстСообщения, "", НужныйСтатус);
	#КонецЕсли
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ НАЧАЛЬНОЙ НАСТРОЙКИ ОТЧЕТА

Функция ПолучитьТекстЗапросаОтчета() Экспорт
	
	//(( sk_181012 Отредактирован запрос в рамках оптимизации
	//ТекстЗапроса = "ВЫБРАТЬ
	//               |	КатегорииОбъектов.Объект
	//               |ПОМЕСТИТЬ СписокДокументов
	//               |ИЗ
	//               |	РегистрСведений.КатегорииОбъектов КАК КатегорииОбъектов
	//               |ГДЕ
	//               |	КатегорииОбъектов.Категория = &КатегорияСозданВМУ
	//               |	И ТИПЗНАЧЕНИЯ(КатегорииОбъектов.Объект) В (&СписокТиповДокументов)
	//               |;
	//               |
	//               |////////////////////////////////////////////////////////////////////////////////
	//               |ВЫБРАТЬ
	//               |	СписокДокументов.Объект КАК Ссылка,
	//               |	СписокДокументов.Объект.Дата КАК Дата,
	//               |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СписокДокументов.Объект) КАК Представление,
	//               |	СписокДокументов.Объект.Ответственный КАК Агент,
	//               |	ЗначенияСвойствОбъектовКатегория.Значение КАК Категория,
	//               |	ЗначенияСвойствОбъектовДатаСоздания.Значение КАК ДатаСозданияВМУ
	//               |{ВЫБРАТЬ
	//               |	Дата,
	//               |	Представление.*,
	//               |	Агент.*,
	//               |	Категория.*,
	//               |	ДатаСозданияВМУ.*}
	//               |ИЗ
	//               |	СписокДокументов КАК СписокДокументов
	//               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	//               |			ЗначенияСвойствОбъектов.Объект КАК Объект,
	//               |			ЗначенияСвойствОбъектов.Значение КАК Значение
	//               |		ИЗ
	//               |			РегистрСведений.ЗначенияСвойствОбъектов КАК ЗначенияСвойствОбъектов
	//               |		ГДЕ
	//               |			ЗначенияСвойствОбъектов.Свойство = &СвойствоДатаСоздания) КАК ЗначенияСвойствОбъектовДатаСоздания
	//               |		ПО СписокДокументов.Объект = ЗначенияСвойствОбъектовДатаСоздания.Объект
	//               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	//               |			ЗначенияСвойствОбъектов.Объект КАК Объект,
	//               |			ЗначенияСвойствОбъектов.Значение КАК Значение
	//               |		ИЗ
	//               |			РегистрСведений.ЗначенияСвойствОбъектов КАК ЗначенияСвойствОбъектов
	//               |		ГДЕ
	//               |			ЗначенияСвойствОбъектов.Свойство = &СвойствоКатегория) КАК ЗначенияСвойствОбъектовКатегория
	//               |		ПО СписокДокументов.Объект = ЗначенияСвойствОбъектовКатегория.Объект
	//               |{ГДЕ
	//               |	СписокДокументов.Объект.Дата КАК Дата,
	//               |	СписокДокументов.Объект.Ответственный.* КАК Агент,
	//               |	ЗначенияСвойствОбъектовДатаСоздания.Значение.* КАК ДатаСозданияВМУ}";
	
	ТекстЗапроса = "ВЫБРАТЬ
	               |	КатегорииОбъектов.Объект
	               |ПОМЕСТИТЬ СписокДокументов
	               |ИЗ
	               |	РегистрСведений.КатегорииОбъектов КАК КатегорииОбъектов
	               |ГДЕ
	               |	КатегорииОбъектов.Категория = &КатегорияСозданВМУ
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	КатегорииОбъектов.Объект
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ЗначенияСвойствОбъектов.Объект КАК Объект,
	               |	ЗначенияСвойствОбъектов.Значение КАК Значение,
	               |	ЗначенияСвойствОбъектов.Свойство КАК Свойство
	               |ПОМЕСТИТЬ ЗначенияСвойствОбъектов
	               |ИЗ
	               |	РегистрСведений.ЗначенияСвойствОбъектов КАК ЗначенияСвойствОбъектов
	               |ГДЕ
	               |	(ЗначенияСвойствОбъектов.Свойство = &СвойствоДатаСоздания
	               |			ИЛИ ЗначенияСвойствОбъектов.Свойство = &СвойствоКатегория)
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	Объект
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	СписокДокументов.Объект КАК Ссылка,
	               |	СписокДокументов.Объект.Дата КАК Дата,
	               |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СписокДокументов.Объект) КАК Представление,
	               |	СписокДокументов.Объект.Ответственный КАК Агент,
	               |	ЗначенияСвойствОбъектовКатегория.Значение КАК Категория,
	               |	ЗначенияСвойствОбъектовДатаСоздания.Значение КАК ДатаСозданияВМУ
	               |{ВЫБРАТЬ
	               |	Дата,
	               |	Представление.*,
	               |	Агент.*,
	               |	Категория.*,
	               |	ДатаСозданияВМУ.*}
	               |ИЗ
	               |	СписокДокументов КАК СписокДокументов
	               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	               |			ЗначенияСвойствОбъектов.Объект КАК Объект,
	               |			ЗначенияСвойствОбъектов.Значение КАК Значение
	               |		ИЗ
	               |			ЗначенияСвойствОбъектов КАК ЗначенияСвойствОбъектов
	               |		ГДЕ
	               |			ЗначенияСвойствОбъектов.Свойство = &СвойствоДатаСоздания) КАК ЗначенияСвойствОбъектовДатаСоздания
	               |		ПО СписокДокументов.Объект = ЗначенияСвойствОбъектовДатаСоздания.Объект
	               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	               |			ЗначенияСвойствОбъектов.Объект КАК Объект,
	               |			ЗначенияСвойствОбъектов.Значение КАК Значение
	               |		ИЗ
	               |			ЗначенияСвойствОбъектов КАК ЗначенияСвойствОбъектов
	               |		ГДЕ
	               |			ЗначенияСвойствОбъектов.Свойство = &СвойствоКатегория) КАК ЗначенияСвойствОбъектовКатегория
	               |		ПО СписокДокументов.Объект = ЗначенияСвойствОбъектовКатегория.Объект
	               |{ГДЕ
	               |	СписокДокументов.Объект.Дата КАК Дата,
	               |	СписокДокументов.Объект.Ответственный.* КАК Агент,
	               |	ЗначенияСвойствОбъектовДатаСоздания.Значение.* КАК ДатаСозданияВМУ}
	               |{УПОРЯДОЧИТЬ ПО
	               |	Дата}";
	//)) sk_181012

	Возврат ТекстЗапроса;
КонецФункции

//Процедура установки начальных настроек отчета по метаданным регистра накопления
//
Процедура УстановитьНачальныеНастройки(ДополнительныеПараметры = Неопределено) Экспорт
	
	УниверсальныйОтчет.ПостроительОтчета.АвтоДетальныеЗаписи = Истина;
	// Настройка общих параметров универсального отчета
	//	
	// Содержит название отчета, которое будет выводиться в шапке.
	// Тип: Строка.
	// Пример:	
	ИмяОтчета = Имена["ФормаЗагруженныеДокументы"] + " (версия " + ВерсияМодуля + ")";	
	УниверсальныйОтчет.мНазваниеОтчета = ИмяОтчета;
	
	// Содержит признак необходимости отображения надписи и поля выбора раздела учета в форме настройки.
	// Тип: Булево.
	// Значение по умолчанию: Истина.
	// Пример:
	// УниверсальныйОтчет.мВыбиратьИмяРегистра = Ложь;
	УниверсальныйОтчет.мВыбиратьИмяРегистра = Ложь;
	
	// Содержит имя регистра, по метаданным которого будет выполняться заполнение настроек отчета.
	// Тип: Строка.
	// Пример:
	// УниверсальныйОтчет.ИмяРегистра = "ТоварыНаСкладах";
	УниверсальныйОтчет.ИмяРегистра = "-";
	
	// Содержит признак необходимости вывода в отчет общих итогов.
	// Тип: Булево.
	// Значение по умолчанию: Истина.
	// Пример:
	// УниверсальныйОтчет.ВыводитьОбщиеИтоги = Ложь;
	УниверсальныйОтчет.ВыводитьОбщиеИтоги = Ложь;
	
	// Содержит признак необходимости вывода детальных записей в отчет.
	// Тип: Булево.
	// Значение по умолчанию: Ложь.
	// Пример:
	// УниверсальныйОтчет.ВыводитьДетальныеЗаписи = Истина;
	УниверсальныйОтчет.ВыводитьДетальныеЗаписи = Истина;
	
	// Содержит признак необходимости отображения флага использования свойств и категорий в форме настройки.
	// Тип: Булево.
	// Значение по умолчанию: Истина.
	// Пример:
	 УниверсальныйОтчет.мВыбиратьИспользованиеСвойств = Ложь;
	
	// Содержит признак использования свойств и категорий при заполнении настроек отчета.
	// Тип: Булево.
	// Значение по умолчанию: Ложь.
	// Пример:
	 УниверсальныйОтчет.ИспользоватьСвойстваИКатегории = Ложь;
	
	// Дополнительные параметры, переданные из отчета, вызвавшего расшифровку.
	// Информация, передаваемая в переменной ДополнительныеПараметры, может быть использована
	// для реализации специфичных для данного отчета параметрических настроек.		
	ссылкаСвойствоКатегорияДокумента = ПолучитьСсылкуСвойствоОбъектаАгентПлюс("Категория");
	ссылкаСвойствоДатаСозданияВМУ = ПолучитьСсылкуСвойствоОбъектаАгентПлюс("ДатаСозданияВМУ");
	ссылкаКатегорияСозданВМУ = ПолучитьСсылкуКатегорияОбъектаАгентПлюс("СозданВМУ");
	
	Если ЗначениеЗаполнено(ссылкаСвойствоКатегорияДокумента) И ЗначениеЗаполнено(ссылкаСвойствоКатегорияДокумента) И ЗначениеЗаполнено(ссылкаКатегорияСозданВМУ) Тогда
		СписокТиповДокументов = Новый Массив;
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.ЗаказПокупателя"));
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.РеализацияТоваровУслуг"));
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.ПриходныйКассовыйОрдер"));
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.РасходныйКассовыйОрдер"));
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.ПоступлениеТоваровУслуг"));
		СписокТиповДокументов.Добавить(Тип("ДокументСсылка.ВозвратТоваровОтПокупателя"));		
		
		УниверсальныйОтчет.ПостроительОтчета.Текст = ПолучитьТекстЗапросаОтчета();
				
		УниверсальныйОтчет.ПостроительОтчета.Параметры.Вставить("СписокТиповДокументов", СписокТиповДокументов);
		УниверсальныйОтчет.ПостроительОтчета.Параметры.Вставить("СвойствоКатегория", 	ссылкаСвойствоКатегорияДокумента);
		УниверсальныйОтчет.ПостроительОтчета.Параметры.Вставить("СвойствоДатаСоздания", ссылкаСвойствоДатаСозданияВМУ);
		УниверсальныйОтчет.ПостроительОтчета.Параметры.Вставить("КатегорияСозданВМУ", 	ссылкаКатегорияСозданВМУ);
	КонецЕсли;
	
	//ПолеОтбора = УниверсальныйОтчет.ПостроительОтчета.ДоступныеПоля.Найти("Категория");
	//Если ПолеОтбора <> Неопределено Тогда
	//	ПолеОтбора.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ЗначенияСвойствОбъектов");
	//КонецЕсли;
	//
	//ПолеОтбора = УниверсальныйОтчет.ПостроительОтчета.ДоступныеПоля.Найти("ДатаСозданияВМУ");
	//Если ПолеОтбора <> Неопределено Тогда
	//	ПолеОтбора.ТипЗначения = Новый ОписаниеТипов("Дата");
	//КонецЕсли;
	//
	//ПолеДоговор = УниверсальныйОтчет.ПостроительОтчета.ДоступныеПоля.Найти("ДоговорКонтрагента");
	//Если ПолеДоговор <> Неопределено Тогда
	//	ПолеДоговор.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ДоговорыКонтрагентов");
	//КонецЕсли; 
	
	// Представления полей отчета.
	// Необходимо вызывать для каждого поля запроса.
	// УниверсальныйОтчет.мСтруктураПредставлениеПолей.Вставить(<ИмяПоля>, <ПредставлениеПоля>);	
	УниверсальныйОтчет.мСтруктураПредставлениеПолей.Вставить("Представление", "Документ");
	УниверсальныйОтчет.мСтруктураПредставлениеПолей.Вставить("ДатаСозданияВМУ", "Дата создания в МУ");
	
	// Добавление показателей
	// Необходимо вызывать для каждого добавляемого показателя.
	// УниверсальныйОтчет.ДобавитьПоказатель(<ИмяПоказателя>, <ПредставлениеПоказателя>, <ВключенПоУмолчанию>, <Формат>, <ИмяГруппы>, <ПредставлениеГруппы>);
	
	// Добавление предопределенных группировок строк отчета.
	// Необходимо вызывать для каждой добавляемой группировки строки.
	//УниверсальныйОтчет.ДобавитьИзмерениеСтроки(<ПутьКДанным>);
	
	// Добавление предопределенных группировок колонок отчета.
	// Необходимо вызывать для каждой добавляемой группировки колонки.
	
	// Добавление предопределенных полей порядка отчета.
	// Необходимо вызывать для каждого добавляемого поля порядка.
	// УниверсальныйОтчет.ДобавитьПорядок(<ПутьКДанным>);	
	УниверсальныйОтчет.ДобавитьПорядок("Дата", НаправлениеСортировки.Убыв);
	
	// Установка связи подчиненных и родительских полей
	// УниверсальныйОтчет.УстановитьСвязьПолей(<ПутьКДанным>, <ПутьКДаннымРодитель>);
	
	// Установка связи полей и измерений
	// УниверсальныйОтчет.УстановитьСвязьПоляИИзмерения(<ИмяПоля>, <ИмяИзмерения>);
	
	// Установка представлений полей
	УниверсальныйОтчет.УстановитьПредставленияПолей(УниверсальныйОтчет.мСтруктураПредставлениеПолей, УниверсальныйОтчет.ПостроительОтчета);
	
	// Установка типов значений свойств в отборах отчета
	УниверсальныйОтчет.УстановитьТипыЗначенийСвойствДляОтбора();
		
	// Добавление предопределенных отборов отчета.
	// Необходимо вызывать для каждого добавляемого отбора.
	// УниверсальныйОтчет.ДобавитьОтбор(ПутьКДанным, Использование = Неопределено, ВидСравнения = Неопределено, Значение = Неопределено, ЗначениеС = Неопределено, ЗначениеПо = Неопределено, ИспользоватьВБыстрыхОтборах = Истина);	
	УниверсальныйОтчет.ДобавитьОтбор("Дата", Истина, ВидСравнения.ИнтервалВключаяГраницы, , НачалоДня(ТекущаяДата()), КонецДня(ТекущаяДата()));
	УниверсальныйОтчет.ДобавитьОтбор("Агент");
	//УниверсальныйОтчет.ДобавитьОтбор("Категория", Ложь, , Справочники.ЗначенияСвойствОбъектов.ПустаяСсылка(), , , Истина);
	УниверсальныйОтчет.ДобавитьОтбор("ДатаСозданияВМУ", Ложь, ВидСравнения.ИнтервалВключаяГраницы, , НачалоДня(ТекущаяДата()), КонецДня(ТекущаяДата()), Истина);
	
	// Добавление дополнительных полей
	// Необходимо вызывать для каждого добавляемого дополнительного поля.
	// УниверсальныйОтчет.ДобавитьДополнительноеПоле(<ПутьКДанным>, <Размещение>, <Положение>);
	//УниверсальныйОтчет.ДобавитьДополнительноеПоле("ТипСобытия",     ТипРазмещенияРеквизитовИзмерений.Отдельно, 3);
		
КонецПроцедуры // УстановитьНачальныеНастройки()

//////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ФОРМИРОВАНИЯ ОТЧЕТА 

// Процедура формирования отчета
//
Процедура СформироватьОтчет(ТабличныйДокумент) Экспорт
	
	//  Перед формирование отчета можно установить необходимые параметры универсального отчета.
	//Если УниверсальныйОтчет.ПостроительОтчета.Отбор.Найти("Дата") <> Неопределено Тогда 
	//	Если ЗначениеЗаполнено(ДатаНач) Тогда
	//		УниверсальныйОтчет.ПостроительОтчета.Отбор["Дата"].ЗначениеС     = НачалоДня(ДатаНач);
	//	КонецЕсли;
	//	Если ЗначениеЗаполнено(ДатаКон) Тогда
	//		УниверсальныйОтчет.ПостроительОтчета.Отбор["Дата"].ЗначениеПо    = КонецДня(ДатаКон);
	//	КонецЕсли;
	//КонецЕсли;	
		
	УниверсальныйОтчет.СформироватьОтчет(ТабличныйДокумент);
	
КонецПроцедуры // СформироватьОтчет()

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

// Процедура обработки расшифровки
//
Процедура ОбработкаРасшифровки(Расшифровка, Объект) Экспорт
	
	// Дополнительные параметры в расшифровывающий отчет можно перередать
	// посредством инициализации переменной "ДополнительныеПараметры".
	
	ДополнительныеПараметры = УправлениеОтчетами.СохранитьРеквизитыОтчета(ЭтотОбъект);
	УниверсальныйОтчет.ОбработкаРасшифровкиУниверсальногоОтчета(Расшифровка, Объект, ДополнительныеПараметры);
		
КонецПроцедуры // ОбработкаРасшифровки()

// Формирует структуру для сохранения настроек отчета
//
Процедура СформироватьСтруктуруДляСохраненияНастроек(СтруктураСНастройками) Экспорт
	
	УниверсальныйОтчет.СформироватьСтруктуруДляСохраненияНастроек(СтруктураСНастройками);
	
КонецПроцедуры // СформироватьСтруктуруДляСохраненияНастроек()

// Заполняет настройки отчета из структуры сохраненных настроек
//
Функция ВосстановитьНастройкиИзСтруктуры(СтруктураСНастройками) Экспорт
	
	Возврат УниверсальныйОтчет.ВосстановитьНастройкиИзСтруктуры(СтруктураСНастройками, ЭтотОбъект);
	
КонецФункции // ВосстановитьНастройкиИзСтруктуры()

//// Содержит значение используемого режима ввода периода.
//// Тип: Число.
//// Возможные значения: 0 - произвольный период, 1 - на дату, 2 - неделя, 3 - декада, 4 - месяц, 5 - квартал, 6 - полугодие, 7 - год
//// Значение по умолчанию: 0
//// Пример:
//// УниверсальныйОтчет.мРежимВводаПериода = 1;

#КонецЕсли

////////////////////////////////////////////////////////////////////////////
//ВерсияМодуля = "1.0.0.1"; 
//ВерсияМодуля = "1.0.0.2"; // sk_181012 Исправлено выполнение сортировки. Отредактирован запрос.
ВерсияМодуля = "1.0.0.3"; // sk_190611 Добавлена справка (онлайн)

Имена = Новый Соответствие();
Имена.Вставить("ФормаЗагруженныеДокументы", НСтр("ru='Сведения о загруженных документах'"));

////////////////////////////////////////////////////////////////////////////////
// ЗНАЧЕНИЕ ПЕРЕМЕННЫХ, СКОПИРОВАННЫХ ИЗ МОДУЛЯ ОБМЕНА ДАННЫМИ /////////////////
КоличествоПопыток   = 5;   
ПаузаМеждуПопытками = 10; 

имяСвойства = "СозданВМУ";
Имена.Вставить("КатегорияОбъекта_" + имяСвойства, НСтр("ru='Агент Плюс: Создан в мобильном устройстве'"));	
Имена.Вставить("ИдентификаторКатегорияОбъекта_" + имяСвойства, Новый УникальныйИдентификатор("da9c697f-6e45-4a9f-9869-e063d3706b6c"));		
Имена.Вставить("НазначениеКатегории_" + имяСвойства, ПланыВидовХарактеристик.НазначенияСвойствКатегорийОбъектов.Документы);
//---------
имяСвойства = "Категория";
Имена.Вставить("СвойствоОбъекта_" + имяСвойства, НСтр("ru='Агент Плюс: Категория документа'"));		
Имена.Вставить("ИдентификаторСвойстваОбъекта_" + имяСвойства, Новый УникальныйИдентификатор("8a13ae35-d349-11de-9c3b-001d923fc78e"));		
массивТипов = Новый Массив;
массивТипов.Добавить(Тип("СправочникСсылка.ЗначенияСвойствОбъектов"));
текОписаниеТипов = Новый ОписаниеТипов(МассивТипов);
Имена.Вставить("ТипЗначения_" + имяСвойства, текОписаниеТипов);	
Имена.Вставить("НазначениеСвойства_" + имяСвойства, ПланыВидовХарактеристик.НазначенияСвойствКатегорийОбъектов.Документы);	
//---------
имяСвойства = "ДатаСозданияВМУ";
Имена.Вставить("СвойствоОбъекта_" + имяСвойства, НСтр("ru='Агент Плюс: Дата создания в мобильном устройстве'"));	
Имена.Вставить("ИдентификаторСвойстваОбъекта_" + имяСвойства, Новый УникальныйИдентификатор("a0c7484c-6fae-4e0f-8262-45838a019114"));
массивТипов = Новый Массив;
массивТипов.Добавить(Тип("Дата"));
текОписаниеТипов = Новый ОписаниеТипов(МассивТипов);
Имена.Вставить("ТипЗначения_" + имяСвойства, текОписаниеТипов);	
Имена.Вставить("НазначениеСвойства_" + имяСвойства, ПланыВидовХарактеристик.НазначенияСвойствКатегорийОбъектов.Документы);
