output "folder_id" {
  description = "ID of the folder"
  value       = yandex_resourcemanager_folder.folder.id
}

output "folder_name" {
  description = "Name of the folder"
  value       = yandex_resourcemanager_folder.folder.name
}
