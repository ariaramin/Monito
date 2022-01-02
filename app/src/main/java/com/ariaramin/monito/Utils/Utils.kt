package com.ariaramin.monito.Utils

class Utils {

    fun convertPersianNumber(num: String): String {
        var number = num
        val numbers: HashMap<String, String> = HashMap()
        numbers["0"] = "۰"
        numbers["1"] = "۱"
        numbers["2"] = "۲"
        numbers["3"] = "۳"
        numbers["4"] = "۴"
        numbers["5"] = "۵"
        numbers["6"] = "۶"
        numbers["7"] = "۷"
        numbers["8"] = "۸"
        numbers["9"] = "۹"
        for ((key, value) in numbers.entries) {
            number = number.replace(key, value)
        }
        return number
    }
}