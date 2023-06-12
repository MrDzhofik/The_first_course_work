require 'pg'
require 'faker'

BACHELOR_GROUP = 20000
BACHELOR_STUDENT = 200
MAGISTR_GROUP = 1000
MAGISTR_STUDENT = 50
SPECIALIST_GROUP = 20000
SPECIALIST_STUDENT = 200
KUDO = 10000
REPRIMAND = 10000
BACHELOR_STUDY = 4
MAGISTR_STUDY = 2
SPECIALIST_STUDY = 6

DB = PG.connect(dbname: 'kursach', password: '246858')

Faker::Config.locale = 'ru'
department_codes = {'ИУ1': 'Системы автоматического управления',
                    'ИУ2': 'Приборы и системы ориентации, стабилизации и навигации',
                    'ИУ3': 'Информационные системы и телекоммуникации',
                    'ИУ4': 'Проектирование и технология производства электронной аппаратуры',
                    'ИУ5': 'Системы обработки информации и управления',
                    'ИУ6': 'Компьютерные системы и сети',
                    'ИУ7': 'Программное обеспечение ЭВМ и информационные технологии',
                    'ИУ8': 'Информационная безопасность',
                    'ИУ9': 'Теоретическая информатика и компьютерные технологии',
                    'ИУ11': 'Космические приборы и системы',

    'ФН1': 'Высшая математика',
    'ФН2': 	'Прикладная математика',
    'ФH3': 	'Теоретическая механика',
    'ФH4': 	'Физика',
    'ФH5': 	'Химия',
    'ФН7':	'Электротехника и промышленная электроника',
    'ФH11': 	'Вычислительная математика и математическая физика',
    'ФH12': 	'Математическое моделирование',

    'CМ1': 	'Космические аппараты и ракеты-носители',
    'CМ2': 	'Аэрокосмические системы',
    'CМ3':	'Динамика и управление полетом ракет и космических аппаратов',
    'CМ4': 	'Высокоточные летательные аппараты',
    'CМ5': 	'Автономные информационные и управляющие системы',
    'CМ6': 	'Ракетные и импульсные системы',
    'CМ7': 	'Специальная робототехника и мехатроника',
    'СМ8': 	'Стартовые ракетные комплексы',
    'CМ9': 	'Многоцелевые гусеничные машины и мобильные роботы',
    'CМ10': 	'Колесные машины',
    'CМ11': 	'Подводные роботы и аппараты',
    'CМ12': 	'Технологии ракетно-космического машиностроения',
    'CМ13': 	'Ракетно-космические композитные конструкции',

    'Э1': 	'Ракетные двигатели',
    'Э2': 	'Поршневые двигатели',
    'Э3': 	'Газотурбинные и нетрадиционные энергоустановки',
    'Э4': 	'Холодильная, криогенная техника системы кондиционирования и жизнеобеспечения',
    'Э5': 	'Вакуумная и компрессорная техника',
    'Э6': 	'Теплофизика',
    'Э7': 	'Ядерные реакторы и установки',
    'Э8': 	'Плазменные энергетические установки',
    'Э9': 	'Экология и промышленная безопасность',
    'Э10': 	'Гидромеханика, гидромашины и гидропневмоавтоматика',

    'МТ1': 	'Металлорежущие станки',
    'МТ2': 	'Инструментальная техника и технологии',
    'МТ3':	'Технологии машиностроения',
    'МТ4': 	'Метрология и взаимозаменяемость',
    'МТ5': 	'Литейные технологии',
    'МТ6': 	'Технологии обработки давлением',
    'МТ7': 	'Технологии сварки и диагностики',
    'МТ8':	'Материаловедение',
    'МТ9': 	'Промышленный дизайн',
    'МТ10': 	'Оборудование и технологии прокатки',
    'МТ11': 	'Электронные технологии в машиностроении',
    'МТ12': 	'Лазерные технологии в машиностроении',
    'МТ13': 	'Технологии обработки материалов',


    'ИБМ1': 	'Экономика и бизнес',
    'ИБМ2': 	'Экономика и организация производства',
    'ИБМ3': 	'Промышленная логистика',
    'ИБМ4':	'Менеджмент',
    'ИБМ5': 	'Финансы',
    'ИБМ6':	'Бизнес-информатика',
    'ИБМ7': 	'Инновационное предпринимательство',

    'СГН1': 	'История',
    'СГН2': 	'Социология и культурология',
    'СГН3': 	'Информационная аналитика и политические технологии',
    'СГН4': 	'Философия',

    'ЮР1': 	'Интеллектуальная собственность',
    'ЮР2': 	'Цифровая криминалистика',
    'ЮР3': 	'Правоведение',

    'БМТ1': 	'Биомедицинские технические системы',
    'БМТ2': 	'Медико-технические информационные технологии',
    'БМТ4': 	'Медико-технический менеджмент',

    'РК1': 	'Инженерная графика',
    'РК2': 	'Теория механизмов и машин',
    'РК3':	'Основы конструирования машин',
    'РК4': 	'Подъемно-транспортные системы',
    'РК5': 	'Прикладная механика',
    'РК6':	'Системы автоматизированного проектирования',
    'РК9': 	'Компьютерные системы автоматизации производства'}

# Заполняем кафедры
# department_codes.each_key do |key| 
#   DB.exec "insert into Department (
#             department_id,
#             department_name,
#             phone_number,
#             year_of_creation,
#             head_of_department
#           )
#             values (
#               '#{key}',
#               '#{department_codes[key]}',
#               '#{Faker::PhoneNumber.cell_phone_in_e164}',
#               #{rand(1830..1998)},
#               '#{Faker::Name.name}'
#             );"
# end

array = (DB.exec "SELECT * FROM discipline").to_a
disciplines_id = []
array.each do |elem|
  disciplines_id.append(elem["discipline_id"])
end

# Заполняем данные об преподавателях, студентах и группах
department_code_short = []
department_codes.each do |value, key|
  department_code_short.append(value)
end
bachelor_array = []
magistr_array = []
specialist_array = []

# Группы Бакалавров
p "Группы бакалавров"
BACHELOR_GROUP.times do
  birth = Faker::Date.between(from: '1950-01-01', to: '1995-12-31') # Год рождения преподавателя
  year_t =  birth.year + rand(25..50) # Год вступления в преподаватели
  if year_t <= 2023 
    year = year_t.to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  else
    year = (birth.year + 25).to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  end
  teacher_id = (year[2]).to_s + (year[3]).to_s + 'П' + (rand(100...1000)).to_s
  d_code = department_code_short.sample
  headman = Faker::Name.name
  eight = rand(18..19)
  study = false
  course = 0
  birth_s = Faker::Date.between(from: '2000-01-01', to: '2004-12-30') # Год рождения студента
  year_s = (birth_s.year + eight) # Год вступления в студенты
  if year_s >= 2020
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
  else 
    birth_s = '2004' + '-' + (rand(1..12)).to_s + '-' + birth_s.day.to_s # Год рождения студента = 2004
    year_s = (birth_s.split('-')[0].to_i + 18) # Год вступления в студенты
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
  end
  year_of_end = year_s + BACHELOR_STUDY
  dormitory = false
  military_study = false
  scholarship = 0
  bool = ['false', 'true']
  form_of_study = "Бакалавриат"
  if year_of_end >= 2023 
    study = true
    dormitory = bool.sample
    military_study = bool.sample
    scholarship = rand(0..10000).round(-2) 
  end
  if study 
    course = BACHELOR_STUDY - (year_of_end - 2023)
  end
  if !(0 < course and course <= BACHELOR_STUDY)
    next
  end
  group_id = d_code.to_s + '-' + (course*2).to_s + rand(1..5).to_s + 'Б' + '-' + year_of_end.to_s
  bool = [true, false]
  bachelor_array.append(student_id)
  begin
      DB.exec "insert into teacher (
                teacher_id,
                full_name,
                phone_number,
                department,
                date_of_birth
              )
                values (
                  '#{teacher_id}',
                  '#{Faker::Name.name}',
                  '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                  '#{d_code}',
                  '#{birth}'
                );"
    DB.exec "insert into gruppa (
              group_id,
              headman,
              department,
              mentor,
              student_amount
            )
              values (
                '#{group_id}',
                '#{headman}',
                '#{d_code}',
                '#{teacher_id}',
                #{rand(190..210)}
              );"
    DB.exec "insert into student (
              student_id,
              full_name,
              date_of_birth,
              phone_number,
              grupp,
              passport_number,
              studying,
              course_of_study,
              dormitory,
              form_of_study,
              scholarship,
              year_of_enter,
              year_of_end,
              military_study
            )
              values (
                '#{student_id}',
                '#{headman}',
                '#{birth_s}',
                '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                '#{group_id}',
                '#{rand(2000000000..95000000000)}',
                #{study},
                #{course},
                #{dormitory},
                '#{form_of_study}',
                #{scholarship},
                #{year_of_end  - BACHELOR_STUDY},
                #{year_of_end},
                #{military_study}
              );"
  BACHELOR_STUDENT.times do     
    start = year_of_end - BACHELOR_STUDY - eight 
    start_date = start.to_s + '-01-01' # Начальная дата рождения
    finish_date = start.to_s + '-12-31'
    birth_date = Faker::Date.between(from: start_date, to: finish_date)
    year_s = year_of_end - BACHELOR_STUDY # Год вступления в студенты
    if year_s >= 2020
      student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
    else 
      birth_s = '2004' + '-' + (rand(1..12)).to_s + '-' + birth_s.day.to_s # Год рождения студента = 2004
      year_s = (birth_s.split('-')[0].to_i + 18) # Год вступления в студенты
      student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
    end
    student_id = (year_s % 100).to_s + 'У' + rand(100..1000).to_s
    study = true
    dormitory = bool.sample
    military_study = bool.sample
    scholarship = rand(0..10000).round(-2) 
    course = BACHELOR_STUDY - (year_of_end - 2023)
    if !(0 < course and course <= BACHELOR_STUDY)
      next
    end
    bachelor_array.append(student_id)
    DB.exec "insert into student (
              student_id,
              full_name,
              date_of_birth,
              phone_number,
              grupp,
              passport_number,
              studying,
              course_of_study,
              dormitory,
              form_of_study,
              scholarship,
              year_of_enter,
              year_of_end,
              military_study
            )
              values (
                '#{student_id}',
                '#{Faker::Name.name}',
                '#{birth_date}',
                '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                '#{group_id}',
                '#{rand(2000000000..95000000000)}',
                #{true},
                #{course},
                #{dormitory},
                '#{form_of_study}',
                #{scholarship},
                #{year_of_end - BACHELOR_STUDY},
                #{year_of_end},
                #{military_study}
              );"
  end
              rescue PG::UniqueViolation, PG::DatetimeFieldOverflow
              #   next
              end
end

# Группа магистров
p "Группы магистров"
MAGISTR_GROUP.times do
  birth = Faker::Date.between(from: '1950-01-01', to: '1995-12-31') # Год рождения преподавателя
  year_t =  birth.year + rand(25..50) # Год вступления в преподаватели
  if year_t <= 2023 
    year = year_t.to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  else
    year = (birth.year + 25).to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  end
  teacher_id = (year[2]).to_s + (year[3]).to_s + 'П' + (rand(100...1000)).to_s # Зачетка преподавателя
  d_code = department_code_short.sample
  headman = Faker::Name.name
  eight = rand(22..24)
  study = false
  course = 0
  birth_s = Faker::Date.between(from: '1998-01-01', to: '2001-12-30') # Год рождения студента
  year_s = (birth_s.year + eight) # Год вступления в студенты
  if year_s >= 2022
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
  else 
    birth_s = '2000' + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента = 2004
    year_s = (birth_s.split('-')[0].to_i + 22) # Год вступления в студенты
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
  end
  year_of_end = year_s + MAGISTR_STUDY
  dormitory = false
  military_study = false
  scholarship = 0
  bool = ['false', 'true']
  form_of_study = "Магистратура"
  if year_of_end >= 2023 
    study = true
    dormitory = bool.sample
    military_study = bool.sample
    scholarship = rand(0..10000).round(-2) 
  end
  if study 
    course = MAGISTR_STUDY - (year_of_end - 2023)
  end
  if !(0 < course and course <= MAGISTR_STUDY)
    next
  end
  group_id = d_code.to_s + '-' + (course*2).to_s + rand(1..5).to_s + 'М' + '-' + year_of_end.to_s
  bool = [true, false]
  magistr_array.append(student_id)
  begin
      DB.exec "insert into teacher (
                teacher_id,
                full_name,
                phone_number,
                department,
                date_of_birth
              )
                values (
                  '#{teacher_id}',
                  '#{Faker::Name.name}',
                  '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                  '#{d_code}',
                  '#{birth}'
                );"
    DB.exec "insert into gruppa (
              group_id,
              headman,
              department,
              mentor,
              student_amount
            )
              values (
                '#{group_id}',
                '#{headman}',
                '#{d_code}',
                '#{teacher_id}',
                #{rand(45..55)}
              );"
     DB.exec "insert into student (
                student_id,
                full_name,
                date_of_birth,
                phone_number,
                grupp,
                passport_number,
                studying,
                course_of_study,
                dormitory,
                form_of_study,
                scholarship,
                year_of_enter,
                year_of_end,
                military_study
              )
                values (
                  '#{student_id}',
                  '#{headman}',
                  '#{birth_s}',
                  '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                  '#{group_id}',
                  '#{rand(2000000000..95000000000)}',
                  #{study},
                  #{course},
                  #{dormitory},
                  '#{form_of_study}',
                  #{scholarship},
                  #{year_of_end - MAGISTR_STUDY},
                  #{year_of_end},
                  #{military_study}
                );"
      MAGISTR_STUDENT.times do     
                  start = year_of_end - MAGISTR_STUDY- eight 
                  start_date = start.to_s + '-01-01' # Начальная дата рождения
                  finish_date = start.to_s + '-12-31'
                  birth_date = Faker::Date.between(from: start_date, to: finish_date)
                  year_s = year_of_end - MAGISTR_STUDY # Год вступления в студенты
                  student_id = (year_s % 100).to_s + 'У' + rand(100..1000).to_s
                  study = true
                  dormitory = bool.sample
                  military_study = bool.sample
                  scholarship = rand(0..10000).round(-2) 
                  course = MAGISTR_STUDY - (year_of_end - 2023)
                  if !(0 < course and course <= MAGISTR_STUDY)
                    next
                  end
                  magistr_array.append(student_id)
                  DB.exec "insert into student (
                            student_id,
                            full_name,
                            date_of_birth,
                            phone_number,
                            grupp,
                            passport_number,
                            studying,
                            course_of_study,
                            dormitory,
                            form_of_study,
                            scholarship,
                            year_of_enter,
                            year_of_end,
                            military_study
                          )
                            values (
                              '#{student_id}',
                              '#{Faker::Name.name}',
                              '#{birth_date}',
                              '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                              '#{group_id}',
                              '#{rand(2000000000..95000000000)}',
                              #{true},
                              #{course},
                              #{dormitory},
                              '#{form_of_study}',
                              #{scholarship},
                              #{year_of_end - MAGISTR_STUDY},
                              #{year_of_end},
                              #{military_study}
                            );"
                end
              rescue PG::UniqueViolation, PG::DatetimeFieldOverflow
                next
              end
end
# # Группа специалистов
p "Группы специалистов"
SPECIALIST_GROUP.times do
  birth = Faker::Date.between(from: '1950-01-01', to: '1995-12-31') # Год рождения преподавателя
  year_t =  birth.year + rand(25..40) # Год вступления в преподаватели
  if year_t <= 2023 
    year = year_t.to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  else
    year = (birth.year + 25).to_s + '-' + birth.month.to_s + '-' + birth.day.to_s
  end
  teacher_id = (year[2]).to_s + (year[3]).to_s + 'П' + (rand(100...1000)).to_s
  d_code = department_code_short.sample
  headman = Faker::Name.name
  eight = rand(18..19)
  study = false
  course = 0
  birth_s = Faker::Date.between(from: '2000-01-01', to: '2004-12-30') # Год рождения студента
  year_s = (birth_s.year + eight) # Год вступления в студенты
  if year_s >= 2018
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
  else 
    birth_s = '2004' + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента = 2004
    year_s = (birth_s.split('-')[0].to_i + 18) # Год вступления в студенты
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
  end
  year_of_end = year_s + SPECIALIST_STUDY
  dormitory = false
  military_study = false
  scholarship = 0
  bool = ['false', 'true']
  form_of_study = "Специалитет"
  if year_of_end >= 2023 
    study = true
    dormitory = bool.sample
    military_study = bool.sample
    scholarship = rand(0..10000).round(-2) 
  end
  if study 
    course = SPECIALIST_STUDY - (year_of_end - 2023)
  end
  if !(0 < course and course <= SPECIALIST_STUDY)
    next
  end
  group_id = d_code.to_s + '-' + (course*2).to_s + rand(1..5).to_s + 'С' + '-' + year_of_end.to_s
  specialist_array.append(student_id)
  begin
      DB.exec "insert into teacher (
                teacher_id,
                full_name,
                phone_number,
                department,
                date_of_birth
              )
                values (
                  '#{teacher_id}',
                  '#{Faker::Name.name}',
                  '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                  '#{d_code}',
                  '#{birth}'
                );"
    DB.exec "insert into gruppa (
              group_id,
              headman,
              department,
              mentor,
              student_amount
            )
              values (
                '#{group_id}',
                '#{headman}',
                '#{d_code}',
                '#{teacher_id}',
                #{rand(190..210)}
              );"
              DB.exec "insert into student (
                student_id,
                full_name,
                date_of_birth,
                phone_number,
                grupp,
                passport_number,
                studying,
                course_of_study,
                dormitory,
                form_of_study,
                scholarship,
                year_of_enter,
                year_of_end,
                military_study
              )
                values (
                  '#{student_id}',
                  '#{headman}',
                  '#{birth_s}',
                  '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                  '#{group_id}',
                  '#{rand(2000000000..95000000000)}',
                  #{study},
                  #{course},
                  #{dormitory},
                  '#{form_of_study}',
                  #{scholarship},
                  #{year_of_end - SPECIALIST_STUDY},
                  #{year_of_end},
                  #{military_study}
                );"
        SPECIALIST_STUDENT.times do     
                  start = year_of_end - SPECIALIST_STUDY - eight 
                  start_date = start.to_s + '-01-01' # Начальная дата рождения
                  finish_date = start.to_s + '-12-31'
                  birth_date = Faker::Date.between(from: start_date, to: finish_date)
                  year_s = year_of_end - 6 # Год вступления в студенты
                  student_id = (year_s % 100).to_s + 'У' + rand(100..1000).to_s
                  study = true
                  dormitory = bool.sample
                  military_study = bool.sample
                  scholarship = rand(0..10000).round(-2) 
                  course = SPECIALIST_STUDY - (year_of_end - 2023)
                  if !(0 < course and course <= SPECIALIST_STUDY)
                    next
                  end
                  specialist_array.append(student_id)
                  DB.exec "insert into student (
                            student_id,
                            full_name,
                            date_of_birth,
                            phone_number,
                            grupp,
                            passport_number,
                            studying,
                            course_of_study,
                            dormitory,
                            form_of_study,
                            scholarship,
                            year_of_enter,
                            year_of_end,
                            military_study
                          )
                            values (
                              '#{student_id}',
                              '#{Faker::Name.name}',
                              '#{birth_date}',
                              '#{DB.escape Faker::PhoneNumber.cell_phone_in_e164}',
                              '#{group_id}',
                              '#{rand(2000000000..95000000000)}',
                              #{true},
                              #{course},
                              #{dormitory},
                              '#{form_of_study}',
                              #{scholarship},
                              #{year_of_end  - SPECIALIST_STUDY},
                              #{year_of_end},
                              #{military_study}
                            );"
                end
              rescue PG::UniqueViolation, PG::DatetimeFieldOverflow
                next
              end
end


# Заполняем данные о дисциплинах
# disciplines = {
#   'ИУ1': ['Информатика', 'Теория управления', 'Основы автоматики и систем автоматического управления'],
#   'ИУ2': ['Информатика', 'Технология конструирования ЭВМ ', 'Технология приборостроения', 'Функциональная логика и теория алгоритмов', 'Компонентная база электронных средств', 'Физические основы микроэлектроники', 'Основы аналого-цифровой схемотехники ', 
#     'Электроника и микроэлектроника ', 'Технологические процессы микроэлектроники', 'Конструкторское проектирование электронных
#     средств', 'Современные технологии в производстве электронных средств', 'Технология коммутационных систем'],
#   'ИУ3': ['Информатика', 'Учебный практикум на ЭВМ ', 'Алгоритмы и структуры данных', 'Технология программирования ', 'Электроника', 'Управление данными ' ,'Метрология и информационно-измерительные
#     устройства', 'Основы теории управления и цифровой обработки
#     сигналов', 'Микропроцессорная техника и цифровые автоматы ', 'Моделирование и надежность систем'],
#   'ИУ4': ['Информатика', 'Технология конструирования ЭВМ ', 'Технология приборостроения', 'Функциональная логика и теория алгоритмов', 'Компонентная база электронных средств', 'Физические основы микроэлектроники', 'Основы аналого-цифровой схемотехники ', 
#   'Электроника и микроэлектроника ', 'Технологические процессы микроэлектроники', 'Конструкторское проектирование электронных
#   средств', 'Современные технологии в производстве электронных средств', 'Технология коммутационных систем'],
#   'ИУ5': ['Информатика', 'Основы программирования ', 'Архитектура автоматизированных систем обработки
#     информации и управления', 'Программирование на основе классов и шаблонов', 'Электротехника', 'Модели данных', 'Базы данных', 'Системное программирование ', 'Схемотехника дискретных устройств ' , 'Электроника', 'Вычислительные средства АСОИУ', 'Операционные системы' , 'Сети и телекоммуникации' ,'Описание процессов жизненного цикла АСОИУ' , 'Сетевые технологии в АСОИУ'],
#   'ИУ6': ['Информатика', 'Операционные системы', 'Сети и телекоммуникации', 'Схемотехника', 'Технология разработки программных систем', 'Основы программирования', 'Базы данных', 'Электротехника', 'Электроника', 'искретная математика', 'Научная организация инженерного труда,
# стандартизация и сертификация', 'Сети и телекоммуникации ', 'Коммутация и маршрутизация трафика в
# распределённых системах', 'Защита информации', 'бъектно-ориентированное программирование', 'Языки интернет-программирования', 'Машинно-зависимые языки и основы компиляции', 'Прикладная теория цифровых автоматов', 'Современные средства разработки программного
# обеспечения', 'Конструирование и технология производства вычислительной техники', 'Микропроцессорные системы', 'Основы проектирования уcтройств ЭВМ', 
# 'Организация ЭВМ и систем', 'Теория систем и системный анализ', 'Основы теории управления', 'Разработка интернет-приложени', 'Теория информации'],
#   'ИУ7': ['Информатика', 'Технология конструирования ЭВМ ', 'Функциональная логика и теория алгоритмов', 'Компонентная база электронных средств', 'Физические основы микроэлектроники', 'Основы аналого-цифровой схемотехники ', 
#   'Электроника и микроэлектроника ', 'Технологические процессы микроэлектроники', 'Технология коммутационных систем'],
#   'ИУ8': ['Информатика', 'Технология конструирования ЭВМ '],
#   'ИУ9': ['Основы информатики ', 'Дискретная математика', 'Алгебра ', 'Обыкновенные дифференциальные уравнения', 'Алгоритмы компьютерной графики', 'Базы данных', 'Теория формальных языков ', 'Функциональный анализ', 'Основы теории Галуа', 'Численные методы ', 'Конструирование компиляторов', 'Основы теории колец ', 'Физика ', 'Численные методы линейной алгебры', 'Численные методы линейной алгебры', 'Языки и методы программирования ', 'Компьютерные сети', 'Низкоуровневое программирование ', 'Операционные системы', 'Разработка параллельных и распределенных
#     программ', 'Генерация оптимального кода', 'Объектно-функциональное программирование', 'Объектно-функциональное программирование', 'Методы оптимизации ', 'Моделирование'],
  
  
#   'БМТ1': ['Электротехника', 'Электроника и микроэлектроника', 'Общая биология', 'Биохимия', 'Основы патологии ', 'Биофизика', 'Теория случайных процессов ', 'Биомеханика', 'Метрология, стандартизация и технические
#     измерения', 'Основы взаимодействия физических полей с биообъектами' , 'Конструкционные и биоматериалы', 'Биотехнические системы медицинского назначения'],
#   'БМТ2': ['Биохимия', 'Биофизика', 'Биофизические основы живых систем', 'Основы моделирования биотехнических систем ', 'Биотехнические системы медицинского назначения', 'Методы обработки биомедицинских сигналов', 'Основы медицинской акустики'],
#   'БМТ4': ['Общая биология', 'Паталогические анатомия и физиология', 'Основы менеджмента в биомедицинской инженерии', 'Основы технической и биомедицинской оптики', 'Системный анализ и принятие решений', 'Клиническая терапия и хирургия'],

#   'РК1': ['Начертательная геометрия ', 'Инженерная графика'],
#   'РК2': ['Теория механизмов и машин', 'Прикладная механика'],
#   'РК3': ['Детали машин'],
#   'РК5': ['Сопротивление материалов ', 'Прикладная механика'],
#   'РК6': ['Информатика', 'Основы программирования ', 'Программное обеспечение систем
#     автоматизированного проектирования', 'Теория вероятностей и математическая статистика', 'Электротехника', 'Базы данных', 'Базы данных', 'Основы автоматизированного проектирования', 
#     'Электроника', 'Сети и телекоммуникации', 'Операционные системы', 'Вычислительная математика', 'Методы комбинаторных вычислений ', 'Геометрическое моделирование', 'Разработка программных систем', 'Схемотехника'],
  
#   'СГН1': ['История', 'История науки и техники'],
#   'СГН2': ['Социология', 'Культурология', 'Инженерная этика'],
#   'СГН3': ['Политология'],
#   'СГН4': ['Философия'],

#   'ФН1': ['Аналитическая геометрия', 'Математический анализ', 'Линейная алгебра и функции нескольких
#     переменных', 'Интегралы и дифференциальные уравнения', 'Теория функций комплексного переменного и
#     операционное исчисление', 'Интегральные преобразования и уравнения
#     математической физики'],
#   'ФН2': ['Кратные интегралы, теория поля, ряды ', 'Аналитическая геометрия', 'Математический анализ', 'Интегралы и дифференциальные уравнения', 'Теория функций комплексного переменного', 'Алгебра и элементы тензорного анализа', 'Функциональный анализ и интегральные уравнения', 'Дифференциальная геометрия ', 'Методы оптимизации и вариационное исчисление', 
#   ' Математические модели механики сплошной среды', 'Основы математического моделирования', 'История математики'],
#   'ФH3': ['Теоретическая механика', 'Механика деформируемого твердого тела', 'Механика жидкости и газа', 'История механики ', 'Аналитическая механика', 'Введение в астрометрию', 'Колебания механических систем', 'Небесная механика', 'Оптимизация и вычислительная диагностика
#     динамических систем', 'Введение в теорию динамических систем', 'Методы и модели алгебры, дифференциальной
#     геометрии и топологии в механике', 'Основы неголономной механики', 'Основы теории устойчивости', 'Волновые процессы в жидких средах ', 'Динамика сложных механических систем', 'Оптимальное управление механическими
#     системами', 'Управление динамическими системами по обратной
#     связи', 'Механика космического полета'],
#   'ФH4': ['Физика'],
#   'ФH5': ['Химия'],
#   'ФН7': ['Электротехника'],
#   'ФH11': ['Интегралы и дифференциальные уравнения', 'Математический анализ', 'Линейная алгебра и функции нескольких
#     переменных', 'Уравнения математической физики', 'Численные методы', 'Методы оптимизации и вариационное исчисление'],
#   'ФH12': ['Интегралы и дифференциальные уравнения', 'Математический анализ', 'Вычислительная математика', 'Аналитическая геометрия', 'Линейная алгебра и функции нескольких
#       переменных', 'Теория поля и ряды', 'Уравнения математической физики и
#       преобразования Фурье', 'Теория вероятностей и случайные процессы ', 'Теория вероятностей и математическая статистика', 'Дополнительные главы математического анализа', 'Комплексный анализ ', 'Дифференциальные уравнения в частных
#       производных', ' Дискретная математика', 'Исследование операций'],
  
#   'Э2': ['Введение в нетрадиционные и возобновляемые источники энергии', 'Механика жидкости и газа', 'Твердотельное моделирование и основы
#     инженерного синтеза', 'Теория поршневых двигателей', 'Динамика и конструирование поршневых
#     двигателей', 'Моделирование и оптимизация энергетических
#     установок', 'Управление в технических системах'],
#   'Э6': ['Термодинамика наносистем', 'Механика жидкости и газа', 'Термодинамика', 'Основы теории тепломассообмена', 'Квантовая физика', 'Источники, концентраторы, приемники энергии'],
#   'Э9': ['Экология', 'Безопасность жизнедеятельности ', 'Экология техносферы', 'Основы ветроэнергетики', 'Ветроэнергетические установки', 'Экологическое воздействие энергоиспользования'],
#   'Э10': ['Механика жидкости и газа', 'Двигатели на альтернативных топливах ', 'Двигатели на возобновляемых топливах '],

#   'МТ4': ['Метрология, стандартизация и сертификация '],
#   'МТ11': ['Основы автоматизированного проектирования ', 'Физико-химические основы электронных
#     технологий', 'Метрология, стандартизация и взаимозаменяемость', 'Физические основы электронных приборов', 'Процессы и оборудование микротехнологии ', 'Физика вакуума 
#     ', 'Вакуумные системы технологического
#     оборудования', 'Термовакуумные процессы и оборудование', 'Техника эксперимента в электронике и
#     наноэлектронике', 'Системы автоматического управления', 'Технология электронного машиностроения ' ,'Информационное обеспечение разработок'],
#   'МТ13': ['Технология конструкционных материалов'],
  
#   'ЮР2': ['Основы антикоррупционной деятельности в
#     Российской Федерации'],
#   'ЮР3': ['Правоведение '],

#   'ИБМ2': ['Экономика'],
#   'ИБМ3': ['Экономика'],
#   'ИБМ6': ['Экономика'],

#   'CМ10': ['Инженерная графика', 'Строительная механика машин', 'Конструкция электромобилей ', 'Управление техническими системами', 'Теория движения колесных машин ' , 'Тяговые электрические машины', 'Электронные и микропроцессорные системы
#     электромобиля', 'Системы управления тяговым электроприводом', 'Системы автоматизированного проектирования
#     электромобилей', 'Бортовые источники энергии и зарядная
#     инфраструктура электромобилей', 'Технологии IoT в автомобильной отрасли '],
  
  
# }

# p "Дисциплины"
# disciplines.each do |key, value|
#   disciplines[key].each do |elem|
#     first = ""
#     elem.split().each do |x|
#       first += x[0].upcase
#     end
#     discipline_id = key.to_s + first
#     DB.exec "insert into discipline (
#               discipline_id,
#               discipline_name,
#               department
#             )
#               values (
#                 '#{discipline_id}',
#                 '#{elem}',
#                 '#{key}'
#               );"
#     rescue PG::UniqueViolation
#       next
#   end
# end

kudo_topics = ['Академическая успеваемость', 'Спортивное достижение', 'Социальная активность', 'Активное участие в студенческой жизни', 'Исследовательская и научная деятельность', 'Творческое достижение']


# # Заполняем поощрения
p "Поощрения"
10000.times do
  birth = Faker::Date.between(from: '1950-01-01', to: '1995-12-31') # Год рождения преподавателя
  form_of_study = ["Специалитет", "Бакалавриат", "Магистратура"]
  form = form_of_study.sample
  eight = rand(18..19)
  birth_year = 2004
  if form == "Специалитет"
    study_year = 6
  elsif form == "Бакалавриат"
    study_year = 4
  else
    study_year = 2
    birth_year = 1998
    eight = rand(22..24)
  end
  study = false
  course = 0
  birth_s = (birth.year.to_i + rand(15..30)).to_s + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента
  year_s = birth_s.split('-')[0].to_i + eight # Год вступления в студенты

  if year_s <= 2022
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
  else 
    birth_s = birth_year.to_s + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента = 2004
    year_s = (birth_s.split('-')[0].to_i + 18) # Год вступления в студенты
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
  end

  student_date = year_s.to_s + '-09-01' # Дата вступления студента в должность
  student_otchislenie = (student_date.split('-')[0].to_i + study_year).to_s + '-08-31' # Дата отчисления студента
  date = Faker::Date.between(from: student_date, to: student_otchislenie)
  month = date.to_s.split('-')[1].to_i
  while (7 <= month and month <= 8)  do
    date = Faker::Date.between(from: student_date, to: student_otchislenie)
    month = date.to_s.split('-')[1].to_i
  end
  DB.exec "insert into kudo (
            student,
            topic,
            give_date
          )
            values (
              '#{student_id}',
              '#{kudo_topics.sample}',
              '#{date}'
            );"
            rescue PG::ForeignKeyViolation
              next
end

reprimand_topics = ['Академическая задолженность', 'Нарушение внутреннего распорядка', 'Несоблюдение требований безопасности', 'Нарушение этических норм']

# Заполняем выговоры
p "Выговоры"
10000.times do
  birth = Faker::Date.between(from: '1950-01-01', to: '1995-12-31') # Год рождения преподавателя
  form_of_study = ["Специалитет", "Бакалавриат", "Магистратура"]
  form = form_of_study.sample
  eight = rand(18..19)
  birth_year = 2004
  if form == "Специалитет"
    study_year = 6
  elsif form == "Бакалавриат"
    study_year = 4
  else
    study_year = 2
    birth_year = 1998
    eight = rand(22..24)
  end
  study = false
  course = 0
  birth_s = (birth.year.to_i + rand(15..30)).to_s + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента
  year_s = birth_s.split('-')[0].to_i + eight # Год вступления в студенты

  if year_s <= 2022
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s
  else 
    birth_s = birth_year.to_s + '-' + (rand(1..12)).to_s + '-' + birth.day.to_s # Год рождения студента = 2004
    year_s = (birth_s.split('-')[0].to_i + 18) # Год вступления в студенты
    student_id = (year_s % 100).to_s + 'У' + (rand(100...1000)).to_s 
  end

  student_date = year_s.to_s + '-09-01' # Дата вступления студента в должность
  student_otchislenie = (student_date.split('-')[0].to_i + study_year).to_s + '-08-31' # Дата отчисления студента
  date = Faker::Date.between(from: student_date, to: student_otchislenie)
  month = date.month
  while (7 <= month and month <= 8)  do
    date = Faker::Date.between(from: student_date, to: student_otchislenie)
    month = date.month
  end
  DB.exec "insert into reprimand (
            student,
            topic,
            give_date
          )
            values (
              '#{student_id}',
              '#{reprimand_topics.sample}',
              '#{date}'
            );"
            rescue PG::ForeignKeyViolation
              next
end

# Заполняем оценки
marks = [2, 5] 
# Для бакалавров
p "Оценки для бакалавров"
bachelor_array.each do |student_id|
  dscp = disciplines_id.sample
  mark_id = dscp + student_id
  d_department = (DB.exec "SELECT department FROM discipline WHERE discipline_id = '#{dscp}'").to_a # Кафедра дисциплины
  t_department = (DB.exec "SELECT teacher_id FROM teacher WHERE department = '#{d_department[0]["department"]}'").to_a # Кафедра преподавателя
  type = ['Экзамен', 'Зачет']
  mark_type = type.sample
  if mark_type == 'Экзамен'
    mark = rand(2..5)
  else
    mark = marks.sample
  end
  period = rand() % 2
  if period
    date = Faker::Date.between(from: '2020-06-10', to: '2020-06-30')
  else
    date = Faker::Date.between(from: '2020-01-10', to: '2020-01-24')
  end
  month = date.month
  temp = rand(1..4)
  year = '20' + (student_id.split('У')[0].to_i + temp).to_s
  if year.to_i > 2023
    year = '2023'
    month = 1
  elsif year.to_i == 2023 and month == 6
    month = 1
  end
  mark_date = year + '-' + month.to_s + '-' + date.day.to_s
  DB.exec "insert into Mark (
    mark_id,
    student,
    teacher,
    discipline,
    mark_type,
    mark,
    mark_date
  ) values (
    '#{mark_id}',
    '#{student_id}',
    '#{t_department.sample["teacher_id"]}',
    '#{dscp}',
    '#{mark_type}',
    #{mark},
    '#{mark_date}'
  );"
  rescue PG::ForeignKeyViolation, PG::UniqueViolation
    next
end
# Для магистров
p "Оценки для бакалавров"
magistr_array.each do |student_id|
  dscp = disciplines_id.sample
  mark_id = dscp + student_id
  d_department = (DB.exec "SELECT department FROM discipline WHERE discipline_id = '#{dscp}'").to_a # Кафедра дисциплины
  t_department = (DB.exec "SELECT teacher_id FROM teacher WHERE department = '#{d_department[0]["department"]}'").to_a # Кафедра преподавателя
  type = ['Экзамен', 'Зачет']
  mark_type = type.sample
  if mark_type == 'Экзамен'
    mark = rand(2..5)
  else
    mark = marks.sample
  end
  period = rand() % 2
  if period
    date = Faker::Date.between(from: '2020-06-10', to: '2020-06-30')
  else
    date = Faker::Date.between(from: '2020-01-10', to: '2020-01-24')
  end
  month = date.month
  temp = rand(1..2)
  year = '20' + (student_id.split('У')[0].to_i + temp).to_s
  if year.to_i > 2023
    year = '2023'
    month = 1
  elsif year.to_i == 2023 and month == 6
    month = 1
  end
  mark_date = year + '-' + month.to_s + '-' + date.day.to_s
  DB.exec "insert into Mark (
    mark_id,
    student,
    teacher,
    discipline,
    mark_type,
    mark,
    mark_date
  ) values (
    '#{mark_id}',
    '#{student_id}',
    '#{t_department.sample["teacher_id"]}',
    '#{dscp}',
    '#{mark_type}',
    #{mark},
    '#{mark_date}'
  );"
  rescue PG::ForeignKeyViolation, PG::UniqueViolation
    next
end
# Для специалистов
p "Оценки для специалистов"
specialist_array.each do |student_id|
  dscp = disciplines_id.sample
  mark_id = dscp + student_id
  d_department = (DB.exec "SELECT department FROM discipline WHERE discipline_id = '#{dscp}'").to_a # Кафедра дисциплины
  t_department = (DB.exec "SELECT teacher_id FROM teacher WHERE department = '#{d_department[0]["department"]}'").to_a # Кафедра преподавателя
  type = ['Экзамен', 'Зачет']
  mark_type = type.sample
  if mark_type == 'Экзамен'
    mark = rand(2..5)
  else
    mark = marks.sample
  end
  period = rand() % 2
  if period
    date = Faker::Date.between(from: '2020-06-10', to: '2020-06-30')
  else
    date = Faker::Date.between(from: '2020-01-10', to: '2020-01-24')
  end
  month = date.month
  temp = rand(1..6)
  year = '20' + (student_id.split('У')[0].to_i + temp).to_s
  if year.to_i > 2023
    year = '2023'
    month = 1
  elsif year.to_i == 2023 and month == 6
    month = 1
  end
  mark_date = year + '-' + month.to_s + '-' + date.day.to_s
  DB.exec "insert into Mark (
    mark_id,
    student,
    teacher,
    discipline,
    mark_type,
    mark,
    mark_date
  ) values (
    '#{mark_id}',
    '#{student_id}',
    '#{t_department.sample["teacher_id"]}',
    '#{dscp}',
    '#{mark_type}',
    #{mark},
    '#{mark_date}'
  );"
  rescue PG::ForeignKeyViolation, PG::UniqueViolation
    next
end