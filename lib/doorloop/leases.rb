# frozen_string_literal: true

module DoorLoop
  class Leases
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('leases', options)
    end

    def retrieve(id)
      @client.get("leases/#{id}")
    end

    def move_in_tenant(params)
      @client.post('leases/move-in', params)
    end

    def move_out_tenant(params)
      @client.post('leases/move-out', params)
    end

    def tenants
      @client.get('leases/tenants')
    end

  end
end

#
# client = DoorLoop::Client.new('your_api_token')
#
# # List all leases with filters
# leases = client.leases.list({
#                               filter_group: 'your_filter_group',
#                               filter_property: 'your_filter_property',
#                               filter_owner: 'your_filter_owner',
#                               filter_text: 'your_filter_text',
#                               filter_start_date_from: 'YYYY-MM-DD',
#                               filter_start_date_to: 'YYYY-MM-DD',
#                               filter_end_date_from: 'YYYY-MM-DD',
#                               filter_end_date_to: 'YYYY-MM-DD',
#                               filter_propertyClass: 'your_filter_property_class',
#                               filter_unit: 'your_filter_unit',
#                               filter_tenant: 'your_filter_tenant',
#                               filter_outstandingBalanceGreaterThan: 100.0,
#                               filter_status: 'your_filter_status',
#                               filter_term: 'your_filter_term'
#                             })



# Move in a tenant
# client.leases.move_in_tenant({
#                               leaseId: "00000020f51bb4",
#                               moveInAt: "2024-07-01",
#                               tenantIds: ["tenant_id_1", "tenant_id_2"],
#                               portalEnabled: true
#                             })


# Move out a tenant
# client.leases.move_out_tenant({
#                                leaseId: "00000020f51bb4",
#                                movedOutAt: "2024-07-01",
#                                tenantIds: ["tenant_id_1", "tenant_id_2"],
#                                portalEnabled: true,
#                                moveOutNoticeAt: "2024-06-01",
#                                moveOutReason: "Tenant requested to move out"
#                              })

