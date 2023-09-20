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

# メソッド化する
def facilitator(members)

# — — — — — — — — — — — — — — — — — — — — —

  # 欠席者の登録
  absentee = []

  # 終了が押されるまで繰り返す
  puts "本日の欠席者を数字で入力してください"
  puts "0.逢見さん  1.近江さん  2.橋本さん  3.原さん  4.松村さん  5.終了"
  a = ["0", "1", "2", "3", "4", "5"]

  while true
    # puts "——————————"
    # puts "number#{number}"
    input_number = gets.chomp
    
    if a.include?(input_number)
        number = input_number.to_i
      if number == 5
        # 5が入力されたら処理を終える
        # puts "5が入力された"
        break
      else
        # 欠席者を登録する
        # puts "5以外"
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
  puts "▼ - 欠席者 - - - - -"
  p absentee

  # — — — — — — — — — — — — — — — — — — — — —
  # 欠席者の有無に応じて順番を入れ替える

  # 欠席者の人数分繰り返す
  if (absentee.length) != 0
    
    i = 1

    absentee.each do | absentee_member |
      # 先頭と欠席者が一致していたら入れ替える
      if members[0] == absentee_member
        # メンバーを入れ替える
        members[0],members[i] = members[i],members[0]
        i += 1
      end

    end

    puts "▼ - 入替確認 - - - - -"
    p members

  end

  "本日のファシリテーターは#{members[0]}さんです。"

end

# メンバーの登録
# 【メモ】できればデータベースに保存したものを取得したい
members = ["逢見", "近江", "橋本", "原", "松村"]

puts facilitator(members)