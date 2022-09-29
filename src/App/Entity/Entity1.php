<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Entity1
{
    #[ORM\Id, ORM\GeneratedValue, ORM\Column]
    private int $id;

    #[ORM\Column]
    private string $field01;

    #[ORM\Column]
    private int $field02;

    #[ORM\Column]
    private bool $field03;
}
