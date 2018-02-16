<?php

namespace SergeyNezbritskiy\Deploy\Api;

/**
 * Interface DeployModeConfigInterface
 * @package SergeyNezbritskiy\Deploy\Api
 */
interface DeployModeConfigInterface
{

    /**
     * @return bool
     */
    public function useFormKey(): bool;

    /**
     * @return int
     */
    public function getSessionLifetime(): int;

    /**
     * @return bool
     */
    public function shareAdminAccount(): bool;
}