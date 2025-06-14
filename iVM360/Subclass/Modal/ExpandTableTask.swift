//
//  ExpandTableTask.swift
//  DexgoHousekeeping
//
//  Created by Apple on 15/09/22.
//

import UIKit

class AddTaskList: Codable{
    var username : String
    var addressId : String
    var is_verify_image_required       : String
    var is_verify_review_required      : String
    var verify_image_submited_status    : String
    var verify_review_submited_status    : String
    var trip_id                             : String
    var porter_id                           : String
    var porter_gender                       : String
    var porter_healthy_type                 : String
    var bed_number                          : String
    var ip_number                           : String
    var patient_name                        : String
    var note                                : String
    var is_notification_sent                : String
    var hospital_id                         : String
    var company_id                          : String
    var source_address_id                   : String
    var created_date                        : String
    var modified_date                       : String
    var created_by                          : String
    var modified_by                         : String
    var skill_type                          : String
    var trip_time                           : String
    var trip_start_time                     : String
    var trip_end_time                       : String
    var is_suspacious                       : String
    var schedule_time                       : String
    var first_notification_send             : String
    var second_notification_send            : String
    var accept_date                         : String
    var nurse_station_date                  : String
    var pickup_date                         : String
    var start_date                          : String
    var end_date                            : String
    var trip_priority                       : String
    var service_type_id                     : String
    var room_number                         : String
    var last_status_update_time             : String
    var is_clubable                         : String
    var trip_status_id                      : String
    var type_id                             : String
    var beacon_id                           : String
    var gps_location                        : String
    var address_id                          : String
    var hospital_shift_id                   : String
    var reason_id                           : String
    var trip_drop_address_xref_id           : String
    var start_beacon_id                     : String
    var start_beacon_code                   : String
    var start_address_id                    : String
    var end_beacon_id                       : String
    var end_beacon_code                     : String
    var end_address_id                      : String
    var start_gps_location                  : String
    var end_gps_location                    : String
    var address_name                        : String
    var floor_id                            : String
    var building_id                         : String
    var is_active                           : String
    var is_active_for_drop                  : String
    var address_qr_code                     : String
    var request_description                 : String
    var trip_status_text                    : String
    var questionStatus : String
    var questionStatusId : String
    var completion_time : String
    var task_times : String
    var task_name : String
    var tripId : String
    var hk_tasklist_id : String
    var is_start_image            : String
    var is_start_image_required          : String
    var is_end_image          : String
    var is_end_mage_required          : String
    var is_start_review          : String
    var is_start_review_required          : String
    var in_end_review          : String
    var is_end_review_required          : String
    
    var start_image_submitted_status  : String
    var start_review_submitted_status : String
    var end_image_submitted_status    : String
    var end_review_submitted_status   : String
    
    
    
    
   var isselectedAddress = false

init(){
    self.username = ""
    self.addressId = ""
    self.is_verify_image_required      = ""
    self.is_verify_review_required     = ""
    self.verify_image_submited_status   = ""
    self.verify_review_submited_status  = ""
    
    self.trip_id                              = ""
    self.porter_id                            = ""
    self.porter_gender                        = ""
    self.porter_healthy_type                  = ""
    self.bed_number                           = ""
    self.ip_number                            = ""
    self.patient_name                         = ""
    self.note                                 = ""
    self.is_notification_sent                 = ""
    self.hospital_id                          = ""
    self.company_id                           = ""
    self.source_address_id                    = ""
    self.created_date                         = ""
    self.modified_date                        = ""
    self.created_by                           = ""
    self.modified_by                          = ""
    self.skill_type                           = ""
    self.trip_time                            = ""
    self.trip_start_time                      = ""
    self.trip_end_time                        = ""
    self.is_suspacious                        = ""
    self.schedule_time                        = ""
    self.first_notification_send              = ""
    self.second_notification_send             = ""
    self.accept_date                          = ""
    self.nurse_station_date                   = ""
    self.pickup_date                          = ""
    self.start_date                           = ""
    self.end_date                             = ""
    self.trip_priority                        = ""
    self.service_type_id                      = ""
    self.room_number                          = ""
    self.last_status_update_time              = ""
    self.is_clubable                          = ""
    self.trip_status_id                       = ""
    self.type_id                              = ""
    self.beacon_id                            = ""
    self.gps_location                         = ""
    self.address_id                           = ""
    self.hospital_shift_id                    = ""
    self.reason_id                            = ""
    self.trip_drop_address_xref_id            = ""
    self.start_beacon_id                      = ""
    self.start_beacon_code                    = ""
    self.start_address_id                     = ""
    self.end_beacon_id                        = ""
    self.end_beacon_code                      = ""
    self.end_address_id                       = ""
    self.start_gps_location                   = ""
    self.end_gps_location                     = ""
    self.address_name                         = ""
    self.floor_id                             = ""
    self.building_id                          = ""
    self.is_active                            = ""
    self.is_active_for_drop                   = ""
    self.address_qr_code                      = ""
    self.request_description                  = ""
    self.trip_status_text                     = ""
    self.questionStatus = ""
    self.questionStatusId = ""
    self.completion_time = ""
    self.task_times = ""
    self.task_name = ""
    self.tripId = ""
    self.hk_tasklist_id = ""
    
    self.is_start_image                = ""
    self.is_start_image_required   = ""
    self.is_end_image   = ""
    self.is_end_mage_required   = ""
    self.is_start_review   = ""
    self.is_start_review_required   = ""
    self.in_end_review   = ""
    self.is_end_review_required   = ""
    self.start_image_submitted_status          = ""
    self.start_review_submitted_status    = ""
    self.end_image_submitted_status    = ""
    self.end_review_submitted_status    = ""
    }
convenience init(withData data:[String:Any]){
   self.init()
    
    self.is_verify_image_required      = String(describing: data["is_verify_image_required"] ?? "")
    self.is_verify_review_required     = String(describing: data["is_verify_review_required"] ?? "")
    self.verify_image_submited_status   = String(describing: data["verify_image_submited_status"] ?? "")
    self.verify_review_submited_status  = String(describing: data["verify_review_submited_status"] ?? "")
    
    
    self.username = String(describing: data["username"] ?? "")
    self.addressId = String(describing: data["addressId"] ?? "")
    self.trip_id                    = String(describing: data["trip_id"] ?? "")
    self.porter_id                  = String(describing: data["porter_id"] ?? "")
    self.porter_gender              = String(describing: data["porter_gender"] ?? "")
    self.porter_healthy_type        = String(describing: data["porter_healthy_type"] ?? "")
    self.bed_number                 = String(describing: data["bed_number"] ?? "")
    self.ip_number                  = String(describing: data["ip_number"] ?? "")
    self.patient_name               = String(describing: data["patient_name"] ?? "")
    self.note                       = String(describing: data["note"] ?? "")
    self.is_notification_sent       = String(describing: data["is_notification_sent"] ?? "")
    self.hospital_id                = String(describing: data["hospital_id"] ?? "")
    self.company_id                 = String(describing: data["company_id"] ?? "")
    self.source_address_id          = String(describing: data["source_address_id"] ?? "")
    self.created_date               = String(describing: data["created_date"] ?? "")
    self.modified_date              = String(describing: data["modified_date"] ?? "")
    self.created_by                 = String(describing: data["created_by"] ?? "")
    self.modified_by                = String(describing: data["modified_by"] ?? "")
    self.skill_type                 = String(describing: data["skill_type"] ?? "")
    self.trip_time                  = String(describing: data["trip_time"] ?? "")
    self.trip_start_time            = String(describing: data["trip_start_time"] ?? "")
    self.trip_end_time              = String(describing: data["trip_end_time"] ?? "")
    self.is_suspacious              = String(describing: data["is_suspacious"] ?? "")
    self.schedule_time              = String(describing: data["schedule_time"] ?? "")
    self.first_notification_send    = String(describing: data["first_notification_send"] ?? "")
    self.second_notification_send   = String(describing: data["second_notification_send"] ?? "")
    self.accept_date                = String(describing: data["accept_date"] ?? "")
    self.nurse_station_date         = String(describing: data["nurse_station_date"] ?? "")
    self.pickup_date                = String(describing: data["pickup_date"] ?? "")
    self.start_date                 = String(describing: data["start_date"] ?? "")
    self.end_date                   = String(describing: data["end_date"] ?? "")
    self.trip_priority              = String(describing: data["trip_priority"] ?? "")
    self.service_type_id            = String(describing: data["service_type_id"] ?? "")
    self.room_number                = String(describing: data["room_number"] ?? "")
    self.last_status_update_time    = String(describing: data["addressId"] ?? "")
    self.is_clubable                = String(describing: data["is_clubable"] ?? "")
    self.trip_status_id             = String(describing: data["trip_status_id"] ?? "")
    self.type_id                    = String(describing: data["type_id"] ?? "")
    self.beacon_id                  = String(describing: data["beacon_id"] ?? "")
    self.gps_location               = String(describing: data["gps_location"] ?? "")
    self.address_id                 = String(describing: data["address_id"] ?? "")
    self.hospital_shift_id          = String(describing: data["hospital_shift_id"] ?? "")
    self.reason_id                  = String(describing: data["reason_id"] ?? "")
    self.trip_drop_address_xref_id  = String(describing: data["trip_drop_address_xref_id"] ?? "")
    self.start_beacon_id            = String(describing: data["start_beacon_id"] ?? "")
    self.start_beacon_code          = String(describing: data["start_beacon_code"] ?? "")
    self.start_address_id           = String(describing: data["start_address_id"] ?? "")
    self.end_beacon_id              = String(describing: data["end_beacon_id"] ?? "")
    self.end_beacon_code            = String(describing: data["end_beacon_code"] ?? "")
    self.end_address_id             = String(describing: data["end_address_id"] ?? "")
    self.start_gps_location         = String(describing: data["start_gps_location"] ?? "")
    self.end_gps_location           = String(describing: data["end_gps_location"] ?? "")
    self.address_name               = String(describing: data["address_name"] ?? "")
    self.floor_id                   = String(describing: data["floor_id"] ?? "")
    self.building_id                = String(describing: data["building_id"] ?? "")
    self.is_active                  = String(describing: data["is_active"] ?? "")
    self.is_active_for_drop         = String(describing: data["is_active_for_drop"] ?? "")
    self.address_qr_code            = String(describing: data["address_qr_code"] ?? "")
    self.request_description        = String(describing: data["request_description"] ?? "")
    self.trip_status_text           = String(describing: data["trip_status_text"] ?? "")
    self.questionStatus           = String(describing: data["questionStatus"] ?? "")
    self.questionStatusId           = String(describing: data["questionStatusId"] ?? "")
    self.completion_time           = String(describing: data["completion_time"] ?? "")
    self.task_times           = String(describing: data["task_times"] ?? "")
    self.task_name           = String(describing: data["task_name"] ?? "")
    self.tripId           = String(describing: data["tripId"] ?? "")
    self.hk_tasklist_id           = String(describing: data["hk_tasklist_id"] ?? "")
    self.is_start_image                       = String(describing: data["is_start_image"] ?? "")
    self.is_start_image_required             = String(describing: data["is_start_image_required"] ?? "")
    self.is_end_image             = String(describing: data["is_end_image"] ?? "")
    self.is_end_mage_required             = String(describing: data["is_end_mage_required"] ?? "")
    self.is_start_review             = String(describing: data["is_start_review"] ?? "")
    self.is_start_review_required             = String(describing: data["is_start_review_required"] ?? "")
    self.in_end_review             = String(describing: data["in_end_review"] ?? "")
    self.is_end_review_required             = String(describing: data["is_end_review_required"] ?? "")
    
    self.start_image_submitted_status  = String(describing: data["start_image_submitted_status"] ?? "")
    self.start_review_submitted_status = String(describing: data["start_review_submitted_status"] ?? "")
    self.end_image_submitted_status    = String(describing: data["end_image_submitted_status"] ?? "")
    self.end_review_submitted_status   = String(describing: data["end_review_submitted_status"] ?? "")
    }
}
  
