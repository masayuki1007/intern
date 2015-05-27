#アニメタイトルの読み込み
str = File.read("title_id.csv")
anime = str.split("\n")

#csvの読み込み
file = open("user_anime_matrix.csv","r:UTF-8")
 
#要素が0の行列を定義
matrix_1 = Array.new(536089){Array.new(29){0}}
 
#matrix_1にcsvを読み込み
j = 0
file.each_line do |line|
    lineAry = line.split(",")
    for i in 1..29 do
	    matrix_1[j][i-1] = lineAry[i-1].to_i
	end
	j = j+ 1
end
file.close
 
#出力先ファイルの用意
file_out = open('anime_usr_matrix.csv',"w") 
 
#matrixをcsv形式で出力
for i in 1..29 do
	for j in 1..536089 do
		file_out.print(matrix_1[j-1][i-1].to_s + "\,")
	end
	file_out.puts(anime[i-1])
end
file_out.close