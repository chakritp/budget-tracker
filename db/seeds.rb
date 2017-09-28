# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(first_name: "Chakrit", last_name: "Prasatwattana", email: "chakritp888@gmail.com", password: "password") unless User.first.present?
payment_method = PaymentMethod.find_or_create_by(payment_type: "Cash", user: User.first)

transaction = Transaction.find_or_create_by(amount: 10.00, name: 'Subway', location: 'Santa Monica', description: '6 inch turkey breast', date: Date.current, payment_method: payment_method, user: User.first, is_expense: true)

