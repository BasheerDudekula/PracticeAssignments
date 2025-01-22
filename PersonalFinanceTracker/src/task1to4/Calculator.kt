package task1to4

fun calculator(num1:Double,num2:Double,operation:String):Double?{
    return when(operation){
        "+"->num1+num2
        "-"->num1-num2
        "*"->num1*num2
        "/"->if(num2!=0.0)num1/num2 else null
        else->null
    }
}
fun main(){
    val num1 = 10.0
    val num2 = 5.0
    val operation = "+"
    val result = calculator(num1, num2, operation)
    if (result != null) {
        println("Result: $result")
    } else {
        println("Invalid operation or division by zero!")
    }
    println(calculator(10.0, 5.0, "+"))
    println(calculator(10.0, 5.0, "-"))
    println(calculator(10.0, 5.0, "*"))
    println(calculator(10.0, 0.0, "/"))
}
