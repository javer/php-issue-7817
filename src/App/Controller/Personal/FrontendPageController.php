<?php

namespace App\Controller\Personal;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route(methods: ['GET'])]
final class FrontendPageController
{
    /**
     * Profile action.
     */
    #[Route(path: '/profile', name: 'profile_index')]
    #[Route(path: '/profile2', name: 'profile2_index')]
    #[Route(path: '/profile3', name: 'profile3_index')]
    #[Route(path: '/profile4', name: 'profile4_index')]
    #[Route(path: '/profile5', name: 'profile5_index')]
    #[Route(path: '/profile6', name: 'profile6_index')]
    #[Route(path: '/profile7', name: 'profile7_index')]
    #[Route(path: '/profile8', name: 'profile8_index')]
    #[Route(path: '/profile9', name: 'profile9_index')]
    #[Route(path: '/profile10', name: 'profile10_index')]
    public function __invoke(): Response
    {
        return new Response();
    }
}
