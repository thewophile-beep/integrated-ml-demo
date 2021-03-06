import { common } from "./common"

export const environment = {
  production: true,
  flask_url: "http://localhost:4040/api/integratedML/",
  flask_build: false, 
  cos_url: common.cos_url,
  dataRobotUrl: common.dataRobotUrl,
  titanicTable: common.titanicTable,
  titanicVariables: common.titanicVariables,
  noshowTable: common.noshowTable,
  noshowVariables: common.noshowVariables,
}