<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\AiService;

class AiController extends Controller
{
    protected $aiService;

    public function __construct(AiService $aiService)
    {
        $this->aiService = $aiService;
    }

    public function ask(Request $request)
    {
        $request->validate([
            'message' => 'required|string|max:500',
        ]);

        $message = $request->input('message');
        
        // 1. Detect Intent
        $intent = $this->aiService->detectIntent($message);
        
        // 2. Fetch Context
        $context = $this->aiService->fetchContext($intent, $message);

        // 3. Ask AI with Context
        $response = $this->aiService->ask($message, $context);

        return response()->json([
            'response' => $response,
            'intent' => $intent,
            'context_data' => $context
        ]);
    }
}
