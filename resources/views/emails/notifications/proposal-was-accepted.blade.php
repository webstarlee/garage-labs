@extends('emails.notifications.email')
@section('title', $config['title'])
@section('text', $config['text'])
@section('button')
<a href="{{ url("user/messages/thread/$conversation->id") }}" class="m_-924623658832769187cta-button" style="width:300px;margin:0;padding:0;display:inline-block;background:black;color:black;text-decoration:none;padding:15px 25px;border:1px solid white;font-size:14px;letter-spacing:4px;font-weight:50;margin:20px auto;color:white;text-transform: uppercase;text-align:center">{{$config['link_text']}}</a>
@endsection