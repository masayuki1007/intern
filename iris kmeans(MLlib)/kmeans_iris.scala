import org.apache.spark.SparkContext
import org.apache.spark.mllib.clustering.KMeans
import org.apache.spark.mllib.linalg.Vectors
import java.io.PrintWriter

object KMeansIris extends App {
  val context = new SparkContext("local", "demo")

  val data = context.
    textFile("iris.data").
    filter(_.nonEmpty).
    map { s =>
      val elems = s.split(",")
      (elems.last, Vectors.dense(elems.init.map(_.toDouble)))
    }

  val k = 4 // クラスタの個数を指定します
  val maxItreations = 100 // K-means のイテレーション最大回数を指定します
  val clusters = KMeans.train(data.map(_._2), k, maxItreations)

  var p = new PrintWriter("test.txt")

  // 各データがどのクラスタに分類されたのかを確認する
  println("## 各データのクラスタリング結果")
  data.foreach { tuple =>
    p.println(f"${tuple._2.toArray.mkString("[", ", ", "]")}%s " +
      f"(${tuple._1}%s) : cluster = ${clusters.predict(tuple._2)}%d")
  }
  p.flush
  p.close
}