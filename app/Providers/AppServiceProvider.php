<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Ensure generated asset/api URLs use https in production behind reverse proxy.
        if ($this->app->environment('production')) {
            URL::forceScheme('https');
        }

        // Force Laravel to generate frontend reset password URL
        ResetPassword::createUrlUsing(function ($notifiable, string $token) {

            // Read frontend URL from .env
            $frontendUrl = config('app.frontend_url');

            return $frontendUrl
                . "/reset-password?token=" . $token .
                "&email=" . urlencode($notifiable->email);
        });
    }
}
