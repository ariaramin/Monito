package com.ariaramin.monito.ui.onBoarding

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.findNavController
import com.ariaramin.monito.adapter.ViewPagerAdapter
import com.ariaramin.monito.R
import com.ariaramin.monito.databinding.FragmentViewpagerBinding
import com.ariaramin.monito.sharedPreferences.SharedPreferencesManager
import com.ariaramin.monito.ui.onBoarding.screens.*
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class ViewPagerFragment : Fragment() {

    private var _binding: FragmentViewpagerBinding? = null
    private val binding get() = _binding!!
    @Inject
    lateinit var preferencesManager: SharedPreferencesManager

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentViewpagerBinding.inflate(inflater, container, false)
        setUpDotsIndicatorToViewPager()
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.nextButton.setOnClickListener {
            binding.motionLayout.transitionToEnd()
            if (getViewPagerItem(0) < 4) {
                binding.onBoardingViewPager.currentItem = getViewPagerItem(1)
            } else {
                navigateToNextPage()
            }
        }
        binding.skipButton.setOnClickListener {
            navigateToNextPage()
        }
    }

    private fun navigateToNextPage() {
        preferencesManager.setOnBoardingStatus(true)
        findNavController().navigate(R.id.action_viewPagerFragment_to_homeFragment)
    }

    private fun setUpDotsIndicatorToViewPager() {
        val fragmentList = listOf(
            FirstScreenFragment(),
            SecondScreenFragment(),
            ThirdScreenFragment(),
            FourthScreenFragment(),
            FifthScreenFragment()
        )
        val adapter = ViewPagerAdapter(
            fragmentList,
            childFragmentManager,
            lifecycle
        )
        binding.onBoardingViewPager.adapter = adapter
        binding.dotsIndicator.attachTo(binding.onBoardingViewPager)
    }

    private fun getViewPagerItem(position: Int): Int {
        return binding.onBoardingViewPager.currentItem + position
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}