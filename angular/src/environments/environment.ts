import { common } from "./common"

export const environment = {
  production: false,
  flask_url: "http://localhost:4041/api/integratedML/",
  cos_url: common.cos_url,
  dataRobotUrl: common.dataRobotUrl,
  titanicTable: common.titanicTable,
  titanicVariables: common.titanicVariables,
  noshowTable: common.noshowTable,
  noshowVariables: common.noshowVariables,
}