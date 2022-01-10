package com.ariaramin.monito.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.widget.*
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Adapters.CategoryItemListener
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Dialogs.CategoriesBottomSheet
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Utils.Utils
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory
import com.google.android.material.floatingactionbutton.FloatingActionButton
import ir.hamsaa.persiandatepicker.PersianDatePickerDialog
import ir.hamsaa.persiandatepicker.api.PersianPickerDate
import ir.hamsaa.persiandatepicker.api.PersianPickerListener
import net.objecthunter.exp4j.ExpressionBuilder
import saman.zamani.persiandate.PersianDate
import saman.zamani.persiandate.PersianDateFormat

class TransactionActivity : AppCompatActivity(), CategoryItemListener {

    private var amountEditText: EditText? = null
    private var calculateEditText: EditText? = null
    private var dateTextView: TextView? = null
    private val utils = Utils()

    companion object {
        private var bottomSheet: CategoriesBottomSheet? = null
        private var selectedCategory: Category? = null
        private var categoryImageView: ImageView? = null
        private var categoryTextView: TextView? = null
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_transaction)

        val database = AppDatabase.getInstance(applicationContext)
        val transactionRepository = TransactionRepository(database)
        val transactionFactory = TransactionViewModelFactory(transactionRepository)
        val viewModel =
            ViewModelProvider(this, transactionFactory).get(TransactionViewModel::class.java)

        val backToHome = findViewById<ImageView>(R.id.backImageView)
        backToHome.setOnClickListener {
            finish()
        }

        // Choose category bottom sheet
        bottomSheet = CategoriesBottomSheet()
        bottomSheet!!.isCancelable = false
        bottomSheet!!.show(supportFragmentManager, bottomSheet!!.tag)

        amountEditText = findViewById<EditText>(R.id.resultEditText)
        calculateEditText = findViewById<EditText>(R.id.calculateEditText)
        val categoryLayout = findViewById<RelativeLayout>(R.id.selectCategoryLayout)
        categoryLayout.setOnClickListener {
            bottomSheet = CategoriesBottomSheet()
            bottomSheet!!.show(supportFragmentManager, bottomSheet!!.tag)
        }
        categoryImageView = findViewById<ImageView>(R.id.selectCategoryImageView)
        categoryTextView = findViewById<TextView>(R.id.selectCategoryTextView)
        dateTextView = findViewById<TextView>(R.id.selectDateTextView)
        setCurrentDate()
        val dateLayout = findViewById<RelativeLayout>(R.id.selectDateLayout)
        dateLayout.setOnClickListener {
            showDatePicker()
        }
        val noteEditText = findViewById<EditText>(R.id.noteEditText)
        val saveButton = findViewById<FloatingActionButton>(R.id.saveFab)

        if (selectedCategory == null || amountEditText!!.text.isEmpty()) {
            saveButton.setOnClickListener(null)
        }

        amountEditText!!.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                if (selectedCategory == null || amountEditText!!.text.isEmpty()) {
                    saveButton.setOnClickListener(null)
                } else {
                    saveButton.setOnClickListener {
                        val category = selectedCategory!!
                        val note = noteEditText.text.toString()
                        val amount =
                            if (amountEditText!!.text.isEmpty()) "0" else amountEditText!!.text.toString()
                        val date = dateTextView!!.tag.toString()
                        val transaction = Transaction(
                            category,
                            note,
                            amount,
                            date
                        )
                        viewModel.insertTransaction(transaction)
                        finish()
                    }
                }
            }

            override fun afterTextChanged(s: Editable?) {

            }

        })

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
            if (calculateEditText!!.text.isNotEmpty() && calculateEditText!!.text.last() != '+') {
                updateText("+")
            }
        }

        val minusBtn = findViewById<Button>(R.id.minusBtn)
        minusBtn.setOnClickListener {
            if (calculateEditText!!.text.isNotEmpty() && calculateEditText!!.text.last() != '-') {
                updateText("-")
            }
        }

        val multiplicationBtn = findViewById<Button>(R.id.multiplicationBtn)
        multiplicationBtn.setOnClickListener {
            if (calculateEditText!!.text.isNotEmpty() && calculateEditText!!.text.last() != '×') {
                updateText("×")
            }
        }

        val divisionBtn = findViewById<Button>(R.id.divisionBtn)
        divisionBtn.setOnClickListener {
            if (calculateEditText!!.text.isNotEmpty() && calculateEditText!!.text.last() != '÷') {
                updateText("÷")
            }
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
        val oldStr = utils.convertEnglishNumber(calculateEditText!!.text.toString())
        val cursorPos = calculateEditText!!.selectionStart
        val leftStr = oldStr.substring(0, cursorPos)
        val rightStr = oldStr.substring(cursorPos)
        val result = "$leftStr$newStr$rightStr"
        calculateEditText!!.setText(utils.convertPersianNumber(result))
        calculateEditText!!.setSelection(cursorPos + 1)
        calculate()
    }

    private fun calculate() {
        var str = utils.convertEnglishNumber(calculateEditText!!.text.toString())
        str = str.replace("×", "*")
        str = str.replace("÷", "/")
        if (str.isNotEmpty()) {
            try {
                val expression = ExpressionBuilder(str).build()
                val result = expression.evaluate()
                amountEditText!!.setText(utils.convertPersianNumber(result.toInt().toString()))
            } catch (e: Exception) {

            }
        } else {
            amountEditText!!.setText("")
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

    private fun showDatePicker() {
        val picker = PersianDatePickerDialog(this)
            .setPositiveButtonString(resources.getString(R.string.ok))
            .setNegativeButton(resources.getString(R.string.cancel))
            .setTodayButton(resources.getString(R.string.today))
            .setActionTextColorResource(R.color.secondaryColor)
            .setAllButtonsTextSize(16)
            .setTodayButtonVisible(true)
            .setMinYear(1300)
            .setMaxYear(1500)
            .setMaxMonth(12)
            .setMaxDay(31)
            .setInitDate(
                PersianDatePickerDialog.THIS_YEAR,
                PersianDatePickerDialog.THIS_MONTH,
                PersianDatePickerDialog.THIS_DAY
            )
            .setTitleType(PersianDatePickerDialog.WEEKDAY_DAY_MONTH_YEAR)
            .setShowInBottomSheet(true)
            .setListener(object : PersianPickerListener {
                override fun onDateSelected(persianPickerDate: PersianPickerDate?) {
                    val year = persianPickerDate!!.persianYear
                    val month = if (persianPickerDate.persianMonth < 10)
                        "0${persianPickerDate.persianMonth}" else
                        persianPickerDate.persianMonth
                    val monthName = persianPickerDate.persianMonthName
                    val day = persianPickerDate.persianDay
                    val date = "${year}-${month}-${day}"
                    dateTextView!!.tag = date
                    val longDate = "${utils.convertPersianNumber(day.toString())} $monthName ${
                        utils.convertPersianNumber(year.toString())
                    }"
                    dateTextView!!.text = longDate
                }

                override fun onDismissed() {

                }
            })
        picker.show()
    }

    override fun OnItemClick(category: Category) {
        selectedCategory = category
        categoryTextView!!.text = category.title
        categoryImageView!!.setImageBitmap(category.image)
        bottomSheet!!.dismiss()
    }
}