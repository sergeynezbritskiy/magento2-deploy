<?php

namespace SergeyNezbritskiy\Deploy\Service;

use SergeyNezbritskiy\Deploy\Api\DeployModeConfigInterface;

/**
 * Class DeployModeDeveloperConfig
 * @package SergeyNezbritskiy\Deploy\Service
 */
class DeployModeDeveloperConfig implements DeployModeConfigInterface
{

    /**
     * @return bool
     */
    public function useFormKey(): bool
    {
        return false;
    }

    /**
     * @return int
     */
    public function getSessionLifetime(): int
    {
        return 31536000;
    }

    /**
     * @return bool
     */
    public function shareAdminAccount(): bool
    {
        return true;
    }
}