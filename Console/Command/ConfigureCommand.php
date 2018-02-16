<?php

namespace SergeyNezbritskiy\Deploy\Console\Command;

use Magento\Framework\App\Config\ConfigResource\ConfigInterface;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Store\Model\Store;
use SergeyNezbritskiy\Deploy\Service\DeployModeConfigFactory;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Class ConfigureCommand
 * @package Magento\Backend\Console\Command
 */
class ConfigureCommand extends Command
{

    /**
     * @var ConfigInterface
     */
    private $resourceConfig;

    /**
     * @var DeployModeConfigFactory
     */
    private $configFactory;

    /**
     * Configure constructor.
     * @param ConfigInterface $resourceConfig
     * @param DeployModeConfigFactory $configFactory
     * @param string $name
     */
    public function __construct(ConfigInterface $resourceConfig, DeployModeConfigFactory $configFactory, $name = null)
    {
        parent::__construct($name);
        $this->resourceConfig = $resourceConfig;
        $this->configFactory = $configFactory;
    }

    /**
     * {@inheritdoc}
     */
    protected function configure()
    {
        $this->setName('deploy:mode:configure');
        $this->setDescription('Set up configuration suitable for chosen deploy mode');
        $this->setDefinition($this->getInputList());
        parent::configure();
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     * @throws \Exception
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $deployMode = $input->getArgument('mode');
        $config = $this->configFactory->create($deployMode);

        $output->writeln('<info>Start configuring</info>');

        $output->writeln('Use form key: ' . ($config->useFormKey() ? 'true' : 'false'));
        $this->resourceConfig->saveConfig('admin/security/use_form_key', $config->useFormKey(), ScopeConfigInterface::SCOPE_TYPE_DEFAULT, Store::DEFAULT_STORE_ID);

        $output->writeln('Session lifetime: ' . $config->getSessionLifetime());
        $this->resourceConfig->saveConfig('admin/security/session_lifetime', $config->getSessionLifetime(), ScopeConfigInterface::SCOPE_TYPE_DEFAULT, Store::DEFAULT_STORE_ID);

        $output->writeln('Share admin account: ' . ($config->shareAdminAccount() ? 'true' : 'false'));
        $this->resourceConfig->saveConfig('admin/security/admin_account_sharing', $config->shareAdminAccount(), ScopeConfigInterface::SCOPE_TYPE_DEFAULT, Store::DEFAULT_STORE_ID);

        $output->writeln('<info>Deploy mode configured. Please rerun `php bin/magento cache:clean`</info>');
        return 0;
    }

    /**
     * @return array
     */
    private function getInputList(): array
    {
        return [
            new InputArgument('mode', InputArgument::OPTIONAL, 'Deploy mode: either developer or production', DeployModeConfigFactory::DEPLOY_MODE_DEVELOPER),
        ];
    }

}
