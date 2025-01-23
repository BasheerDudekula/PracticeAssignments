package com.example.flightapp.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.navigation.fragment.navArgs
import com.example.flightapp.R

class BookingConfirmationFragment : Fragment() {

    private val args:BookingConfirmationFragmentArgs by navArgs()
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_booking_confirmation, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<TextView>(R.id.airlineName).text=args.airlineName
        view.findViewById<TextView>(R.id.Country).text=args.country
        view.findViewById<TextView>(R.id.itacode).text=args.iatacode
    }
}