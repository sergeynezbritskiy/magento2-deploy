<?php

namespace SergeyNezbritskiy\Deploy\Service;

use SergeyNezbritskiy\Deploy\Api\DeployModeConfigInterface;

/**
 * Class DeployModeProductionConfig
 * @package SergeyNezbritskiy\Deploy\Service
 */
class DeployModeProductionConfig implements DeployModeConfigInterface
{

    /**
     * @return bool
     */
    public function useFormKey(): bool
    {
        return true;
    }

    /**
     * @return int
     */
    public function getSessionLifetime(): int
    {
        return 3600;
    }

    /**
     * @return bool
     */
    public function shareAdminAccount(): bool
    {
        return false;
    }
}