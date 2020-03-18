package terraform

import input.tfplan as tfplan
import input.tfrun as tfrun

allowed_dc = "datacenter-21"

# data "vsphere_datacenter" must query only allowed_dc
deny[reason] {
    r = tfplan.prior_state.values.root_module.resources[_]
    r.mode == "data"
    r.type == "vsphere_datacenter"
    r.values.id != allowed_dc
    reason := sprintf("VMware Datacenter %s is prohibited. Allowed value is: %s",
        [r.values.id, allowed_dc])
}

# datacenter_id attribute of "data" resources must be equal to allowed_dc
deny[reason] {
    r = tfplan.prior_state.values.root_module.resources[_]
    r.mode == "data"
    r.datacenter_id
    r.datacenter_id != allowed_dc
    reason := sprintf("VMware Datacenter %s is prohibited. Allowed value is: %s",
        [r.change.after.datacenter_id, allowed_dc])
}

# datacenter_id attribute of any changing resource must be equal to allowed_dc
deny[reason] {
    r = tfplan.resource_changes[_]
    r.change.after
    r.change.after.datacenter_id != allowed_dc
    reason := sprintf("VMware Datacenter %s is prohibited. Allowed value is: %s",
        [r.change.after.datacenter_id, allowed_dc])
}