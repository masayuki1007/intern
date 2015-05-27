#csvの読み込み
file = open("user_anime_id.csv","r:UTF-8")
 
#536089*29で要素が0の行列を定義
u_t_matrix = Array.new(536089){Array.new(29){0}}
 
#u_t_matrix[user][title]に1を代入していく
file.each_line do |line|
    lineAry = line.split(",")
    u_t_matrix[lineAry[0].to_i-1][lineAry[1].to_i-1] = 1
end
file.close
 
#アニメ間のコサイン類似度を算出
sim_matrix = Array.new(29){Array.new(29){0}}
for i in 1..29 do
	for j in 1..29 do
		if i == j then
			sim_matrix[i-1][j-1] = 0
		else
			sum = 0
			sum_1 = 0
			sum_2 = 0
			for p in 1..536089 do
				#内積
				sum = sum + u_t_matrix[p-1][i-1] * u_t_matrix[p-1][j-1]
				#vec[i]のノルム
				sum_1 = sum_1 + u_t_matrix[p-1][i-1]
				#vec[j]のノルム
				sum_2 = sum_2 + u_t_matrix[p-1][j-1]
			end
			# x**(1/2.0)→xの二乗根
			x = sum_1**(1/2.0)
			y = sum_2**(1/2.0)
			sim_matrix[i-1][j-1] = sum / (x * y)
		end
	end
end
 
 
#出力先ファイルの用意
file_out = open('cos_sim.csv',"w") 
 
#matrixをcsv形式に変換
for i in 1..29 do
	str = ""
  for j in 1..28 do
  	str = str + sim_matrix[i-1][j-1].to_s + "\,"
  end
    str = str + sim_matrix[i-1][29-1].to_s
    file_out.puts(str)
end
 
file_out.close