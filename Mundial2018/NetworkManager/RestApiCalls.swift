//
//  RestApiCalls.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 29/05/21.
//  Copyright © 2021 Aldair. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol apiCallsProtocol{

    func getResponse(response:Response)
    func getErrorResponse(error:NSString)
}

class RestApiCalls: NSObject {
    
    var delegate: apiCallsProtocol!
    var fetching: Bool = false
    private var vUrlApi: String = ""
    private var vTypeMethod: String = ""
    private var vParameters: String = ""
    private var boundary: String = ""
  
    
    func mainResponse(response: Response){
        fetching = false
        delegate?.getResponse(response: response)
    }

    func errorResponse(result:NSString){
        fetching = false
        delegate?.getErrorResponse(error: result)
    }
    
    func getFixtures (targetVC: UIViewController, date: String) {
         let urlApi = "\(Constants.Endpoints.fixtures)\(date)"
        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "GET")
    }
    
    func getGroups (targetVC: UIViewController) {
        let urlApi = "\(Constants.Endpoints.groups)"
        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "GET")
    }
    
    func getStadiums (targetVC: UIViewController) {
         let urlApi = "\(Constants.Endpoints.stadiums)"
        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "GET")
    }
    
//    func getRequisitosExp(targetVC: UIViewController, parameters: String, queryItems:  [URLQueryItem]) {
//        let urlApi = "\(Constants.Endpoints.requisitos_expediente)\(parameters)"
//
//        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "GET", queryItems: queryItems)
//
//    }
    
//    func createExpediente(targetVC: UIViewController, parameters: String) {
//        let urlApi = "\(Constants.Endpoints.expediente)"
//
//        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "POST", parameters: parameters)
//    }
    
//    func getDetailExpediente(targetVC: UIViewController, expedienteID: Int) {
//        let urlApi = "\(Constants.Endpoints.expediente)/\(String(expedienteID))"
//        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "GET")
//    }
    
    
//    func deleteExpediente(targetVC: UIViewController, expedienteID: Int) {
//        let urlApi = "\(Constants.Endpoints.expediente)/\(String(expedienteID))"
//        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "DELETE")
//    }

//    func uploadImage(targetVC:UIViewController, expedienteID: Int, requisito_id: Int, parametro_archivo: String, imageData: Data ) {
//
//        let urlApi = "\(Constants.Endpoints.expediente)/\(String(expedienteID))"
//        print("ApiCall \(requisito_id)")
//        print("apiocd \(parametro_archivo)")
//
//        boundary = "Boundary-\(UUID().uuidString)"
//        let httpBody = NSMutableData()
//        httpBody.appendString(convertFormField(named: "requisito_id", value: "\(requisito_id)", using: boundary))
//        httpBody.appendString(convertFormField(named: "_method", value: "PUT", using: boundary))
//        httpBody.append(convertFileData(fieldName: "\(parametro_archivo)",
//                                        fileName: "\(parametro_archivo).png",
//                                        mimeType: "image/png",
//                                        fileData: imageData,
//                                        using: boundary))
//
//        httpBody.appendString("--\(boundary)--")
//
//        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "POST", is_file: true, httpBody: httpBody as Data)
//    }
//
    
   
     ////////////////////////////////////////   LOGIN - LOGOUT
    func login(targetVC: UIViewController, parameters: String) {
        let urlApi = "\(Constants.Endpoints.login)"
        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "POST", parameters: parameters)
    }
    
    func logout(targetVC: UIViewController) {
        let urlApi = "\(Constants.Endpoints.logout)"
        self.callApi(targetVC: targetVC, urlApi: urlApi, typeMethod: "POST")
    }
    
    
    private func callApi (targetVC: UIViewController, urlApi: String, typeMethod: String, parameters: String = "", is_file: Bool = false, httpBody: Data = Data(), queryItems: [URLQueryItem] = []) {
        
        print("Ruta: \(urlApi)")
        fetching = true
            
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(UIColor.white)
    
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        SVProgressHUD.show()
        UIApplication.shared.beginIgnoringInteractionEvents()
            
        let urlString = "\(Constants.URL.main)\(urlApi)"
        let urlPOST = URL(string:  urlString)!
        let urlGET  = NSURLComponents(string: urlString)!
        
        var urlApiCall: URL? = nil
        
        if typeMethod == "GET" || typeMethod == "PUT" {
            urlGET.queryItems = queryItems
            urlApiCall = urlGET.url
        } else {
            urlApiCall = urlPOST
        }
            
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: urlApiCall!)
        request.httpMethod = typeMethod
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(Constants.access_token, forHTTPHeaderField: "x-token")
            
        
        if is_file {
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
            
        } else {
            print(parameters)
            request.httpBody = parameters.data(using: String.Encoding.utf8)
        }
            
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler:  {
                (data, response, error) in
                
                if error != nil || data == nil {
                    print("error2: \(String(describing: error))")
                    self.checkConnection(targetVC: targetVC, error: error!.localizedDescription)
                    return
                }

                DispatchQueue.main.async(execute: {
                    
                    print("Response: \(String(describing: response))")
                    print("Data: \(String(decoding: data!, as: UTF8.self))")
                    print(data as Any)
                    
                    if let statusCode = response!.getStatusCode() {
                        
                        
                        do {
                            
                            self.dismissLoading()
//                            var dataResponse = NSDictionary()
//                            if "\(String(decoding: data!, as: UTF8.self))" != "" {
//
//                                if let json  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String : AnyObject]] {
//                                    if let data = json[0]["data"] as? NSDictionary {
//
//                                        print(data)
//                                        dataResponse = data
//
//                                    } else {
//                                        let geti: [String: [[String : AnyObject]]] = ["data": json]
//                                        print(geti)
//                                        dataResponse = geti as NSDictionary
//                                    }
//
//
//
//                                } else if let gettingData  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary  {
//
//                                    print("is NSDictionary: \(gettingData)")
//                                    dataResponse = gettingData
//
//                                } else {
//                                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)// No error thrown, but not NSDictionary
//                                    print("Error could not parse JSON: \(jsonStr)")
//
//                                    AlertErrorGral.alertStatusCode(targetVC: targetVC, code: 0, funcion: urlApi, data: NSDictionary())
//                                    return
//                                }
//                            }
                            let response = try! JSONDecoder().decode(Response.self,from: data! )
                            
                            print("Error Code: \(statusCode)")
                            if statusCode >= 200 && statusCode < 300 {
                                
                                self.mainResponse(response: response)
                                
                            } else {
                                self.dismissLoading()
                                let dataResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                AlertErrorGral.alertStatusCode(targetVC: targetVC, code: statusCode, funcion: urlApi, data: dataResponse)
                                self.errorResponse(result: "\(statusCode)" as NSString)
                                
                            }
                            
                            
                                             
                        }
                        catch {
                            print("error General")
                            self.dismissLoading()
                            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)// No
                            AlertErrorGral.alertStatusCode(targetVC: targetVC, code: 0, funcion: urlApi, data: NSDictionary())
                            self.errorResponse(result: "Error General")
                            
                        }
                        
                        
                    }
                })
                
            
                       
            })
            
            
            
            task.resume()
        
        
    }
    
    
    
    
    private func checkConnection (targetVC: UIViewController, error: String)  {
        
        
        if connectionCheck.isConnectedToNetwork() {
            connectionCheck.isInternetAvailable(webSiteToPing: nil) { (isInternetAvailable) in
                guard isInternetAvailable else {
                    // Inform user for example
                   
                    self.dismissLoading()
                    DispatchQueue.main.async(execute: {
                       AlertErrorGral.alertErrorInternet(targetVC: targetVC)
                       self.errorResponse(result: "Error de Internet")
                    })
                    
                    return
                }
                
                // Do some action if there is Internet
                
                DispatchQueue.main.async(execute: {
                    self.dismissLoading()
                    
                    if error == "The request timed out." {
                        AlertErrorGral.alertErrorTimedOut(targetVC: targetVC)
                        self.errorResponse(result: "Error de tiempo de espera")
                    } else {
                        AlertErrorGral.alertErrorServer(targetVC: targetVC)
                        self.errorResponse(result: "Error de Servidor")
                    }
                    
                    
                })
                
                
                
                
            }
        } else {
            
            
            DispatchQueue.main.async(execute: {
                self.dismissLoading()
                AlertErrorGral.alertErrorConexion(targetVC: targetVC)
                self.errorResponse(result: "Error de Conexión")
            })
            
            
        }
        
        
    }
    
    private func dismissLoading () {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
        })
           
    }
    
    ///////////////////////////  FOR UPLOAD FILES
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
    

    
}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}


extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
