package com.ariaramin.monito.Dialogs

import android.app.Dialog
import android.os.Bundle
import androidx.fragment.app.DialogFragment
import android.app.AlertDialog
import android.content.Context
import android.graphics.drawable.BitmapDrawable
import android.view.LayoutInflater
import android.widget.Button
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Adapters.ItemEventListener
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Utils.Utils
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory
import com.google.android.material.chip.Chip
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout
import ir.hamsaa.persiandatepicker.PersianDatePickerDialog
import ir.hamsaa.persiandatepicker.api.PersianPickerDate
import ir.hamsaa.persiandatepicker.api.PersianPickerListener
import saman.zamani.persiandate.PersianDateFormat
import saman.zamani.persiandate.PersianDate

class TransactionDialog() : DialogFragment(), ItemEventListener {

    private lateinit var viewModel: TransactionViewModel
    private lateinit var callback: DialogListener

    companion object {
        private var bottomSheet: CategoriesBottomSheet? = null
        private var dateChip: Chip? = null
        private var categoryChip: Chip? = null
        private var selectedCategory: Category? = null
    }
//
//    override fun onAttach(context: Context) {
//        super.onAttach(context)
//        callback = context as DialogListener
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val database = AppDatabase.getInstance(requireContext())
        val transactionRepository = TransactionRepository(database)
        val factory = TransactionViewModelFactory(transactionRepository)
        viewModel = ViewModelProvider(this, factory).get(TransactionViewModel::class.java)
    }

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val builder = AlertDialog.Builder(activity)
        val view = LayoutInflater.from(activity).inflate(R.layout.transaction_dialog, null, false)
        val amountEditTextLayout =
            view.findViewById<TextInputLayout>(R.id.amountDialogEditTextLayout)
        val amountEditText = view.findViewById<TextInputEditText>(R.id.amountDialogEditText)
        val noteEditText = view.findViewById<TextInputEditText>(R.id.noteDialogEditText)
        dateChip = view.findViewById<Chip>(R.id.dateChip)
        dateChip!!.setOnClickListener {
            showDatePicker()
        }
        categoryChip = view.findViewById<Chip>(R.id.categoryChip)
        categoryChip!!.setOnClickListener {
            bottomSheet = CategoriesBottomSheet()
            bottomSheet!!.show(parentFragmentManager, bottomSheet!!.tag)
        }
        val saveTransactionButton = view.findViewById<Button>(R.id.saveTransactionButton)
        saveTransactionButton.setOnClickListener {
            if (amountEditText.length() > 0) {
                val transaction = Transaction(
                    selectedCategory!!,
                    noteEditText.text.toString(),
                    amountEditText.text.toString(),
                    dateChip!!.tag.toString()
                )
                viewModel.insertTransaction(transaction)
                dismiss()
            } else {
                amountEditTextLayout.error = resources.getString(R.string.empty_field_error)
            }
        }
        setCurrentDate()
        builder.setView(view)
        return builder.create()
    }


    private fun setCurrentDate() {
        val persianDate = PersianDate()
        val dateFormat = PersianDateFormat("Y-m-j")
        val longDateFormat =
            PersianDateFormat("j F Y", PersianDateFormat.PersianDateNumberCharacter.FARSI)
        dateChip!!.tag = dateFormat.format(persianDate)
        dateChip!!.text = longDateFormat.format(persianDate)
    }

    private fun showDatePicker() {
        val picker = PersianDatePickerDialog(activity)
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
                    val utils = Utils()
                    val year = persianPickerDate!!.persianYear
                    val month =
                        if (persianPickerDate.persianMonth < 10) "0${persianPickerDate.persianMonth}" else persianPickerDate.persianMonth
                    val monthName = persianPickerDate.persianMonthName
                    val day = persianPickerDate.persianDay
                    val date = "${year}-${month}-${day}"
                    dateChip!!.tag = date
                    val longDate = "${utils.convertPersianNumber(day.toString())} $monthName ${
                        utils.convertPersianNumber(year.toString())
                    }"
                    dateChip!!.text = longDate
                }

                override fun onDismissed() {

                }
            })
        picker.show()
    }

    override fun OnItemClick(category: Category) {
        selectedCategory = category
        categoryChip!!.text = category.title
        categoryChip!!.chipIcon = BitmapDrawable(category.image)
        bottomSheet!!.dismiss()
    }
}

interface DialogListener {
    fun OnAddNewTransaction(transaction: Transaction)

    fun OnEditText(transaction: Transaction)
}
