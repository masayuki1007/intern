##csvの読み込み
sim <- read.csv("cos_sim.csv")
##距離行列に変換
dd <- as.dist(sim)
##クラスタリング（ウォード法）
clust <- hclust(dd,method="ward.D")
##クラスタ番号の割り当て（クラス数=4）
classNUM <- cutree(clust,k=4)

##各クラスタの要素をクラスタ番号で取得
vec1 <- which (classNUM==1)
vec2 <- which (classNUM==2)
vec3 <- which (classNUM==3)
vec4 <- which (classNUM==4)

##クラスタリング結果をデンドログラムで表示
plot(clust,hang=-1,main="ウォード法")


##結果の出力
sink("output.txt")
print("vec1")
vec1
print("vec2")
vec2
print("vec3")
vec3
print("vec4")
vec4
sink()



##クラスタリング手法の選択
average:群平均法
centroid:重心法
median:メディアン法
ward.D:ウォード法