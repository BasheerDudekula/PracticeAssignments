package com.example.socialmediaapp.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.navigation.fragment.navArgs
import com.example.socialmediaapp.R
import com.example.socialmediaapp.model.User
import com.example.socialmediaapp.network.ApiClient
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class UserProfileFragment : Fragment() {

    private val args: UserProfileFragmentArgs by navArgs()
    private lateinit var nameTextView: TextView
    private lateinit var bioTextView: TextView

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val view = inflater.inflate(R.layout.fragment_user_profile, container, false)
        nameTextView = view.findViewById(R.id.name_text_view)
        bioTextView = view.findViewById(R.id.bio_text_view)
        fetchUserProfile()
        return view
    }

    private fun fetchUserProfile() {
        ApiClient.apiService.getUser(args.userId).enqueue(object : Callback<User> {
            override fun onResponse(call: Call<User>, response: Response<User>) {
                if (response.isSuccessful) {
                    response.body()?.let { user ->
                        nameTextView.text = user.name
                        bioTextView.text = user.email
                    }
                } else {
                    Toast.makeText(requireContext(), "Failed to load user profile", Toast.LENGTH_SHORT)
                        .show()
                }
            }

            override fun onFailure(call: Call<User>, t: Throwable) {
                Toast.makeText(requireContext(), "Error: ${t.message}", Toast.LENGTH_SHORT).show()
            }
        })
    }
}