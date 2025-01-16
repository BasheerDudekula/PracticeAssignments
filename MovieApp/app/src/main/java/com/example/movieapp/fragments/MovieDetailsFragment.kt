package com.example.movieapp.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.bumptech.glide.Glide
import com.example.movieapp.R
import com.example.movieapp.model.Movie


class MovieDetailsFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_movie_details, container, false)
        val movie = arguments?.getParcelable<Movie>("selectedMovie")

        view.findViewById<TextView>(R.id.titleTextView).text = movie?.title
        view.findViewById<TextView>(R.id.overviewTextView).text = movie?.overview
        val imageView = view.findViewById<ImageView>(R.id.posterImageView)
        Glide.with(this)
            .load("https://image.tmdb.org/t/p/w500${movie?.poster_path}")
            .into(imageView)

        return view
    }
}