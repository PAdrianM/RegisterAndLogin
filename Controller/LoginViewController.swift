//
//  LoginViewController.swift
//  RegisterAndLogin
//
//  Created by Andrea Hernandez on 1/9/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        //Verifica que todos los campos esten vacios o llenos
        guard let username = userLoginTextField.text, let password = passwordLoginTextField.text,
              !username.isEmpty, !password.isEmpty else {
            // Mostrar mensaje de error si algún campo está vacío
            showAlert(message: "Por favor, complete todos los campos.")
            return
        }
        if let user = fetchUser(username: username, password: password) {
                    // Credenciales válidas, mostrar mensaje de éxito
                    print("Login exitoso para el usuario: \(user.username ?? "")")
                    showAlert(message: "¡Login exitoso!")

                    // Puedes realizar otras acciones después del login exitoso, como navegar a otra pantalla
                } else {
                    // Credenciales inválidas, mostrar mensaje de error
                    showAlert(message: "Credenciales inválidas. Por favor, inténtelo de nuevo.")
                }
    }
    func showAlert(message: String) {
            let alertController = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    func fetchUser(username: String, password: String) -> User? {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

            do {
                let users = try CoreDataStack.shared.persistentContainer.viewContext.fetch(fetchRequest)
                return users.first
            } catch {
                print("Error al buscar usuario en Core Data: \(error)")
                return nil
            }
        }
}
