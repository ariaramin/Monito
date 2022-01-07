package com.ariaramin.monito.Utils

import java.text.NumberFormat
import java.util.*
import kotlin.collections.HashMap

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

    fun convertLongDate(date: String): String {
        val months: HashMap<String, String> = HashMap()
        months["01"] = "فروردین"
        months["02"] = "اردیبهشت"
        months["03"] = "خرداد"
        months["04"] = "تیر"
        months["05"] = "مرداد"
        months["06"] = "شهریور"
        months["07"] = "مهر"
        months["08"] = "آبان"
        months["09"] = "آذر"
        months["10"] = "دی"
        months["11"] = "بهمن"
        months["12"] = "اسفند"
        val dateList = date.split("-").toTypedArray()
        val year = convertPersianNumber(dateList[0])
        var month = dateList[1]
        for ((key, value) in months.entries) {
            month = month.replace(key, value)
        }
        val day = convertPersianNumber(dateList[2])
        return String.format("%s %s %s", day, month, year)
    }

    fun convertPersianPrice(price: String): String {
        var newPrice = price
        newPrice = NumberFormat.getNumberInstance(Locale.US).format(Integer.parseInt(newPrice))
        return convertPersianNumber(newPrice)
    }
}