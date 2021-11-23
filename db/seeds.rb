# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user_1 = User.create(name: "Kevin", email: "kevin@gmail.com", password: "234234")
@group_1 = Group.create(name: "clothes", icon: "https://www.svgrepo.com/show/275006/shirt-clothes.svg", author_id: @user_1.id)
@group_2 = Group.create(name: "foods", icon: "https://www.svgrepo.com/show/366737/food.svg", author_id: @user_1.id)
@contract_1 = Contract.create(name: "Rockys", amount: 60.5, author_id: @user_1.id)
@contract_2 = Contract.create(name: "Starbucks", amount: 20.3, author_id: @user_1.id)
@contract_3 = Contract.create(name: "Kadosh", amount: 25, author_id: @user_1.id)
@group_contract_1 = GroupContract.create(contract_id: @contract_1.id, group_id: @group_2.id)
@group_contract_2 = GroupContract.create(contract_id: @contract_2.id, group_id: @group_2.id)
@group_contract_3 = GroupContract.create(contract_id: @contract_3.id, group_id: @group_1.id)
@group_contract_4 = GroupContract.create(contract_id: @contract_3.id, group_id: @group_2.id)