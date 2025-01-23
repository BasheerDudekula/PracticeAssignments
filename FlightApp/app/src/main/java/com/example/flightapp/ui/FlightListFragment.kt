package com.example.flightapp.ui

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation.findNavController
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.flightapp.R
import com.example.flightapp.adapter.FlightAdapter
import com.example.flightapp.model.FlightResponse
import com.example.flightapp.network.RetrofitInstance
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class FlightListFragment : Fragment() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var flightAdapter: FlightAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_flight_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        recyclerView = view.findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(requireContext())

        flightAdapter = FlightAdapter { flight ->
            val action =
                FlightListFragmentDirections.actionFlightListFragmentToBookingConfirmationFragment(
                    airlineName = flight.airline_name ,
                    country = flight.country_name ,
                    iatacode = flight.iata_code
                )
            findNavController().navigate(action)
        }
        recyclerView.adapter = flightAdapter

        fetchFlights()
    }

    private fun fetchFlights() {
        val apiKey = "9eae501080de69e4cf11540736062fa3" // Replace with your actual API key

        RetrofitInstance.api.getFlights(apiKey).enqueue(object : Callback<FlightResponse> {
            override fun onResponse(
                call: Call<FlightResponse>,
                response: Response<FlightResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.data?.let { flights ->
                        flightAdapter.submitList(flights)
                    }
                } else {
                    Toast.makeText(requireContext(), "Failed to fetch flights", Toast.LENGTH_LONG)
                        .show()
                }
            }

            override fun onFailure(call: Call<FlightResponse>, t: Throwable) {
                Toast.makeText(requireContext(), "Error: ${t.message}", Toast.LENGTH_LONG).show()
                Log.e("FlightList","API_Error",t)
            }
        })
    }
}