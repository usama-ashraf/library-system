# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'admin@bharia.com', password: 'admin123', username: 'admin@bharia.com')

volume = ["1st", "2nd", "3rd", "4th", "5th" ]
50.times do
  title = Faker::Book.title
  sub_title = Faker::Name.last_name
  statement_resource = Faker::Internet.password(10)
  author = Faker::Book.author
  sub_author = Faker::Book.author
  book_type = "Book"
  account_no = Faker::Number.between(1, 1000)
  price = Faker::Number.between(2000, 3000)
  entry_date = Faker::Date.between(1.year.ago, Date.today)
  ddc_no = Faker::Number.decimal(2, 3)
  auth_mark = Faker::Name.initials
  section = Faker::Book.genre
  book_reference = Faker::Boolean.boolean
  book_publisher = Faker::Book.publisher
  place = Faker::Address.city
  book_year = Faker::Number.between(1990, 2018)
  book_source = Faker::Company.name
  book_edition = Faker::Number.between(1990, 2018)
  book_volume = volume.sample
  book_pages = Faker::Number.between(2000, 3000)
  series = Faker::Number.hexadecimal(3)
  language = "English"
  isbn = Faker::Code.isbn
  binding = Faker::Types.string
  cd_flopy = Faker::Types.string
  status = "Available"
  remarks = Faker::Lorem.paragraphs(rand(2..8))
  content = Faker::Lorem.words(rand(2..10))
  notes = Faker::Lorem.paragraphs(rand(2..8))
  subject = Faker::Types.string
  keyword = Faker::Types.string
  suggested_by =Faker::Name.name_with_middle
  discipline = Faker::ProgrammingLanguage.name
  shipping_charges = Faker::Number.between(500, 1000)
Book.create(title: title, sub_title: sub_title, statement_resource: statement_resource, author: author, sub_author: sub_author, book_type: book_type, account_no: account_no, price: price, entry_date: entry_date, ddc_no: ddc_no, auth_mark: auth_mark, section: section, book_reference: book_reference, book_publisher: book_publisher, place: place, book_year: book_year, book_source: book_source, book_edition: book_edition, book_volume: book_volume, book_pages: book_pages, series: series, language: language, isbn: isbn, binding: binding, cd_flopy: cd_flopy, status: status, remarks: remarks, content: content, notes: notes, subject: subject, keyword: keyword, suggested_by: suggested_by, discipline: discipline, shipping_charges: shipping_charges)
end

