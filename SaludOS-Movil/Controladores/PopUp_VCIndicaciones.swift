//
//  PopUp_VCIndicaciones.swift
//  SaludOS-Movil
//
//  Created by Alumno on 01/10/22.
//

import UIKit

class PopUp_VCIndicaciones: UIViewController, UIScrollViewDelegate  {
    
    var cantPaginas = 6
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = cantPaginas
    }
    

    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
