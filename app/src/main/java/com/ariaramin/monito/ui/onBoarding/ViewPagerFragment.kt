package com.ariaramin.monito.ui.onBoarding

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.constraintlayout.motion.widget.MotionLayout
import androidx.navigation.fragment.findNavController
import com.ariaramin.monito.adapter.ViewPagerAdapter
import com.ariaramin.monito.R
import com.ariaramin.monito.databinding.FragmentViewpagerBinding
import com.ariaramin.monito.sharedPreferences.SharedPreferencesManager
import com.ariaramin.monito.ui.onBoarding.screens.*
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject
import kotlin.math.abs

@AndroidEntryPoint
class ViewPagerFragment : Fragment(), MotionLayout.TransitionListener {

    private var _binding: FragmentViewpagerBinding? = null
    private val binding get() = _binding!!
    @Inject
    lateinit var preferencesManager: SharedPreferencesManager
    var animationEnded = false

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
        // disable viewpager swipe
        binding.onBoardingViewPager.isUserInputEnabled = false
        binding.onBoardingViewPager.setPageTransformer(DepthPageTransformer())
        binding.motionLayout.setTransitionListener(this)
        // transform to the next fragment
        binding.nextButton.setOnClickListener {
            if (!animationEnded) {
                binding.motionLayout.transitionToEnd()
            } else {
                transitionToTheNextFragment()
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

    private fun transitionToTheNextFragment() {
        if (getViewPagerItem(0) < 4) {
            binding.onBoardingViewPager.currentItem = getViewPagerItem(1)
        } else {
            navigateToNextPage()
        }
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

    override fun onTransitionStarted(motionLayout: MotionLayout?, startId: Int, endId: Int) {}

    override fun onTransitionChange(
        motionLayout: MotionLayout?,
        startId: Int,
        endId: Int,
        progress: Float
    ) {}

    override fun onTransitionCompleted(motionLayout: MotionLayout?, currentId: Int) {
        transitionToTheNextFragment()
        animationEnded = true
        // enable viewpager swipe
        binding.onBoardingViewPager.isUserInputEnabled = true
    }

    override fun onTransitionTrigger(
        motionLayout: MotionLayout?,
        triggerId: Int,
        positive: Boolean,
        progress: Float
    ) {}
}