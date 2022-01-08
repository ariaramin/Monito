package com.ariaramin.monito.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.*
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils
import com.google.android.material.floatingactionbutton.FloatingActionButton
import net.objecthunter.exp4j.ExpressionBuilder
import saman.zamani.persiandate.PersianDate
import saman.zamani.persiandate.PersianDateFormat

class TransactionActivity : AppCompatActivity() {

    private var resultEditText: EditText? = null
    private var calculateEditText: EditText? = null
    private var dateTextView: TextView? = null
    private val utils = Utils()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_transaction)

        val backToHome = findViewById<ImageView>(R.id.backImageView)
        backToHome.setOnClickListener {
            finish()
        }

        resultEditText = findViewById<EditText>(R.id.resultEditText)
        calculateEditText = findViewById<EditText>(R.id.calculateEditText)
        val categoryImageView = findViewById<ImageView>(R.id.selectCategoryImageView)
        dateTextView = findViewById<TextView>(R.id.selectDateTextView)
        setCurrentDate()
        val dateLayout = findViewById<RelativeLayout>(R.id.selectDateLayout)
        val noteEditText = findViewById<EditText>(R.id.noteEditText)
        val saveButton = findViewById<FloatingActionButton>(R.id.saveFab)

        val zeroBtn = findViewById<Button>(R.id.zeroBtn)
        zeroBtn.setOnClickListener {
            updateText("۰")
        }

        val oneBtn = findViewById<Button>(R.id.oneBtn)
        oneBtn.setOnClickListener {
            updateText("1")
        }

        val twoBtn = findViewById<Button>(R.id.twoBtn)
        twoBtn.setOnClickListener {
            updateText("2")
        }

        val threeBtn = findViewById<Button>(R.id.threeBtn)
        threeBtn.setOnClickListener {
            updateText("3")
        }

        val fourBtn = findViewById<Button>(R.id.fourBtn)
        fourBtn.setOnClickListener {
            updateText("4")
        }

        val fiveBtn = findViewById<Button>(R.id.fiveBtn)
        fiveBtn.setOnClickListener {
            updateText("5")
        }

        val sixBtn = findViewById<Button>(R.id.sixBtn)
        sixBtn.setOnClickListener {
            updateText("6")
        }

        val sevenBtn = findViewById<Button>(R.id.sevenBtn)
        sevenBtn.setOnClickListener {
            updateText("7")
        }

        val eightBtn = findViewById<Button>(R.id.eightBtn)
        eightBtn.setOnClickListener {
            updateText("8")
        }

        val nineBtn = findViewById<Button>(R.id.nineBtn)
        nineBtn.setOnClickListener {
            updateText("9")
        }

        val plusBtn = findViewById<Button>(R.id.plusBtn)
        plusBtn.setOnClickListener {
            updateText("+")
        }

        val minusBtn = findViewById<Button>(R.id.minusBtn)
        minusBtn.setOnClickListener {
            updateText("-")
        }

        val multiplicationBtn = findViewById<Button>(R.id.multiplicationBtn)
        multiplicationBtn.setOnClickListener {
            updateText("×")
        }

        val divisionBtn = findViewById<Button>(R.id.divisionBtn)
        divisionBtn.setOnClickListener {
            updateText("÷")
        }

        val deleteBtn = findViewById<ImageButton>(R.id.deleteBtn)
        deleteBtn.setOnClickListener {
            val strLength = calculateEditText!!.text.length
            val cursorPos = calculateEditText!!.selectionStart
            if (strLength != 0 && cursorPos != 0) {
                val newStr = calculateEditText!!.text.substring(0, strLength - 1)
                calculateEditText!!.setText(newStr)
                calculateEditText!!.setSelection(cursorPos - 1)
            }
            calculate()
        }
    }

    private fun updateText(newStr: String) {
        val oldStr = calculateEditText!!.text
        val cursorPos = calculateEditText!!.selectionStart
        val leftStr = oldStr.substring(0, cursorPos)
        val rightStr = oldStr.substring(cursorPos)
        val result = "$leftStr$newStr$rightStr"
        calculateEditText!!.setText(result)
        calculateEditText!!.setSelection(cursorPos + 1)
        calculate()
    }

    private fun calculate() {
        var str = calculateEditText!!.text.toString()
        str = str.replace("×", "*")
        str = str.replace("÷", "/")
        if (str.isNotEmpty()) {
            try {
                val expression = ExpressionBuilder(str).build()
                val result = expression.evaluate()
                resultEditText!!.setText(result.toInt().toString())
            } catch (e: Exception) {

            }
        } else {
            resultEditText!!.setText("")
        }
        calculateEditText!!.setSelection(calculateEditText!!.text.toString().length)
    }

    private fun setCurrentDate() {
        val persianDate = PersianDate()
        val dateFormat = PersianDateFormat("Y-m-j")
        val longDateFormat =
            PersianDateFormat("j F Y", PersianDateFormat.PersianDateNumberCharacter.FARSI)
        dateTextView!!.tag = dateFormat.format(persianDate)
        dateTextView!!.text = longDateFormat.format(persianDate)
    }
}