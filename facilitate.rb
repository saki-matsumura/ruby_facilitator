# ————————————————————————————————————————
# ■ ファシリテーターを決めるプログラミング
# ————————————————————————————————————————

# ■ シンプルプラン
# 【要件】
# ・【必須】誰が当番なのかわかる
# ・基本メンバーを50音順に配列登録（できればデータベースに保存したい……）
# ・欠席者がいた場合、先頭の名前と比較して一致していたら、欠席者の順番をひとつ後ろに回す。
# 　いなければ先頭の人が本日のファシリテーター
# ・データベースを更新する

# ————————————————————————————————————————

# ファシリテーターを決めるメゾット
def facilitator(members)

# — — — — — — — — — — — — — — — — — — — — —
  # 欠席者の登録
  absentee = []
  # 終了が押されるまで繰り返す
  puts "本日の欠席者を数字で入力してください"
  puts "0.逢見さん  1.近江さん  2.橋本さん  3.原さん  4.松村さん  5.終了"
  numbers = []
    j = 0
    ((members.length)+1).times do
      numbers << "#{j}"
      j += 1
    end

  while true
    input_number = gets.chomp
    if numbers.include?(input_number)
        number = input_number.to_i
      if number == 5
        break
      else
        absentee << members[number]
      end
    else
      puts "0〜5の数字を入力してください。"
      puts "0.逢見さん  1.近江さん  2.橋本さん  3.原さん  4.松村さん  5.終了"
      input_number = gets.chomp
    end
  end
  # 重複削除
  absentee = absentee.uniq

  # — — — — — — — — — — — — — — — — — — — — —
  # 欠席者の有無に応じて順番を入れ替える
  # 欠席者の人数分繰り返す
  return today_facilitator = "本日は全員お休みです。" if  (absentee.length) == 5

  if (absentee.length) != 0 && (absentee.length) != 5
    i = 1
    absentee.each do | absentee_member |
      # 先頭と欠席者が一致していたら入れ替える
      if members[0] == absentee_member
        # メンバーを入れ替える
        members[0],members[i] = members[i],members[0]
        i += 1
      end
    end
    # 本日のファシリテーターを出力
    today_facilitator = "本日のファシリテーターは#{members[0]}さんです。"
  end

  # 配変更した配列をCSVに保存する（途中）
  # 問題点：1行目から更新してしまうため、2回目からハッシュが機能しなくなってしまう。
  # require 'csv'
  # File.open("members.csv", "w") do |f|
  #   members.each { |s| f.puts(s) }
  # end

  # 本日のファシリテーターを返す
  today_facilitator
end

# — — — — — — — — — — — — — — — — — — — — —

# CSVに保存された名簿から、メンバーの名前を取得して配列化する
require 'csv'
members_table = CSV.table('members.csv')

# CSVからメンバーリストを作成する
member_list = []
# member_listに名前を代入
members_table.each do | member_name |
  member_list << member_name[:name]
end

# — — — — — — — — — — — — — — — — — — — — —

# メンバーリストを引数に設定し、ファシリテーターを決めるメソッドを呼び出す
puts facilitator(member_list)