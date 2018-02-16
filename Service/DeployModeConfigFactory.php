<?php

namespace SergeyNezbritskiy\Deploy\Service;

use Exception;
use Magento\Framework\ObjectManagerInterface;
use SergeyNezbritskiy\Deploy\Api\DeployModeConfigInterface;

/**
 * Class ConfigFactory
 * @package SergeyNezbritskiy\Deploy\Service
 */
class DeployModeConfigFactory
{

    const DEPLOY_MODE_DEVELOPER = 'developer';

    const DEPLOY_MODE_PRODUCTION = 'production';

    /**
     * @var ObjectManagerInterface
     */
    private $objectManager;

    /**
     * ConfigFactory constructor.
     * @param ObjectManagerInterface $objectManager
     */
    public function __construct(ObjectManagerInterface $objectManager)
    {
        $this->objectManager = $objectManager;
    }

    /**
     * @param string $deployMode
     * @return DeployModeConfigInterface
     * @throws Exception
     */
    public function create(string $deployMode): DeployModeConfigInterface
    {
        switch ($deployMode) {
            case self::DEPLOY_MODE_DEVELOPER:
                $class = DeployModeDeveloperConfig::class;
                break;
            case self::DEPLOY_MODE_PRODUCTION:
                $class = DeployModeProductionConfig::class;
                break;
            default:
                throw new Exception(sprintf('Deploy mode %s not supported', $deployMode));
        }
        return $this->objectManager->create($class);
    }
}