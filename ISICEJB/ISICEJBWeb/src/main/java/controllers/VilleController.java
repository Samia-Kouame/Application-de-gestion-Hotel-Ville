package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.IDaoLocale;
import dao.IDaoVille;
import entities.Ville;

/**
 * Servlet implementation class VilleController
 */
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private IDaoVille ejb;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VilleController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nom = request.getParameter("ville");
		
		ejb.create(new Ville(nom));
		
		request.setAttribute("villes", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("ville.jsp");
		
		dispatcher.forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String action = request.getParameter("action");

	        if ("create".equals(action)) {
	            String nom = request.getParameter("ville");
	            ejb.create(new Ville(nom));

	            // Après la création, rediriger vers la page VilleController
	            response.sendRedirect(request.getContextPath() + "/VilleController");
	        } else if ("delete".equals(action)) {
			    int VilleId = Integer.parseInt(request.getParameter("id"));
			    if(ejb.findById(VilleId)!=null) {
			    	Ville Villedelete =  ejb.findById(VilleId);
			        boolean updated = ejb.update(Villedelete);
			        if (updated) {
			            ejb.delete(Villedelete);
			            boolean deleted = true;
			            if (deleted) {
			            	List<Ville>VilleList = ejb.findAll();
							request.setAttribute("villes", VilleList);
							request.getRequestDispatcher("ville.jsp").forward(request, response);
			            } else {
			                response.sendRedirect(request.getContextPath() + "/VilleController?deleteFailed=true");
			            }
			        }
			    }
			
	        }else if ("update".equals(action)) {
	            String idParameter = request.getParameter("id");
	            String updatedVilleName = request.getParameter("ville");

	            int id = Integer.parseInt(idParameter);
	            Ville vUpdate = ejb.findById(id);

	            if (vUpdate != null) {
	                vUpdate.setNom(updatedVilleName);
	                ejb.update(vUpdate);
	                response.sendRedirect(request.getContextPath() + "/VilleController?update");
	            } else {
	                System.out.println("Ville non trouvée avec l'ID : " + id);
	            }
	        }

		

		}
	    }
	 
	 