ActiveRecordDoctor.configure do
  global :ignore_tables, [
    # Ignore internal Rails or gems related tables.
    "ar_internal_metadata",
    "schema_migrations",
    "active_storage_blobs",
    "active_storage_attachments",
    "action_text_rich_texts",
    "maintenance_tasks_runs"
  ]

  global :ignore_models, [
    # Ignore internal Rails or gems related models.
    "ActiveStorage::Blob",
    "ActiveStorage::Attachment",
    "ActiveStorage::VariantRecord",
    "ActiveStorage::Preview",
    "ActionText::EncryptedRichText",
    "ActionText::RichText",
    "ActionMailbox::InboundEmail",
    "MaintenanceTasks::Run",
    "SolidCache::Entry",
    "SolidQueue::BlockedExecution",
    "SolidQueue::ClaimedExecution",
    "SolidQueue::FailedExecution",
    "SolidQueue::Job",
    "SolidQueue::Pause",
    "SolidQueue::Process",
    "SolidQueue::ReadyExecution",
    "SolidQueue::RecurringExecution",
    "SolidQueue::RecurringTask",
    "SolidQueue::ScheduledExecution",
    "SolidQueue::Semaphore"
  ]
end
