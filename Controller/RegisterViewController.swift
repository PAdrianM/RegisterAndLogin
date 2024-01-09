//
//  RegisterViewController.swift
//  RegisterAndLogin
//
//  Created by Andrea Hernandez on 1/9/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var succesMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        succesMessageLabel.isHidden = true
        
    }
    @IBAction func registerButtonTaped(_ sender: UIButton) {
        
        //Verifica que todos los campos esten vacios o llenos
        guard let username = userNameTextField.text,
                      let number = numberTextField.text,
                      let email = emailTextField.text,
                      let password = passwordTextField.text,
              !username.isEmpty, !number.isEmpty, !email.isEmpty, !password.isEmpty else {
            // Mostrar mensaje de error si algún campo está vacío
            showAlert(message: "Por favor, complete todos los campos.")
            return
           
        }
        
        // Crear un nuevo objeto User para Core Data
                let newUser = User(context: CoreDataStack.shared.persistentContainer.viewContext)
                newUser.username = username
                newUser.number = number
                newUser.email = email
                newUser.password = password

                // Guardar en Core Data
                do {
                    try CoreDataStack.shared.saveContext()
                    // Mostrar mensaje de éxito
                    succesMessageLabel.isHidden = false
                    print("Usuario registrado:")
                               print("Username: \(newUser.username ?? "")")
                               print("Number: \(newUser.number ?? "")")
                               print("Email: \(newUser.email ?? "")")
                               print("Password: \(newUser.password ?? "")")
                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                          let databaseURL = documentsDirectory.appendingPathComponent("UserAttributes.sqlite")
                          print("Ubicación del archivo de la base de datos: \(databaseURL.path)")
                      }
                } catch {
                    // Manejar el error al guardar en Core Data
                    showAlert(message: "Hubo un error al registrar el usuario. Inténtelo de nuevo.")
                }
            }

            // Método para mostrar alertas
            func showAlert(message: String) {
                let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)

    }
    
}
