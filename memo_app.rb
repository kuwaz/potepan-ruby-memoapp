require 'csv'

def create_new_file
  puts "新規ファイルの名前を入力してください（例: memos.csv）:"
  filename = gets.chomp
  File.open(filename, 'w') { |file| file.write("メモ内容\n") }
  puts "#{filename} が作成されました。"

  # メモの入力を受け付ける
  puts "メモを入力してください（終了するには空の行を入力してください）:"
  entries = []
  while (entry = gets.chomp) != ""
    entries << entry
  end

  CSV.open(filename, 'a') do |csv|
    entries.each { |entry| csv << [entry] }
  end
  puts "#{filename} にメモが追加されました。"
end

def edit_existing_file
  puts "編集するファイルの名前を入力してください（例: memos.csv）:"
  filename = gets.chomp

  unless File.exist?(filename)
    puts "#{filename} は存在しません。"
    return
  end

  puts "メモを入力してください（終了するには空の行を入力してください）:"
  entries = []
  while (entry = gets.chomp) != ""
    entries << entry
  end

  CSV.open(filename, 'a') do |csv|
    entries.each { |entry| csv << [entry] }
  end
  puts "#{filename} が更新されました。"
end

def prompt_user
  loop do
    puts "1: 新規ファイルを作成"
    puts "2: 既存のファイルを編集"
    print "選択肢を入力してください: "
    choice = gets.chomp.to_i

    case choice
    when 1
      create_new_file
      break
    when 2
      edit_existing_file
      break
    else
      puts "不正な値です。1か2を入力してください。"
    end
  end
end

# メイン処理
prompt_user
