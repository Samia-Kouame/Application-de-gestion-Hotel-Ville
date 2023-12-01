package controllers;

import java.io.IOException;
import java.util.List;

import dao.IDaoHotel;
import dao.IDaoLocale;
import dao.IDaoVille;
import entities.Ville;
import entities.Hotel;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HotelController extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	@EJB
	private IDaoHotel ejb;
	@EJB
	private IDaoVille ejb1;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HotelController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Hotel> HotelList = ejb.findAll();
		List<Ville> VilleList = ejb1.findAll();
		request.setAttribute("hotels", HotelList);
		request.setAttribute("villes", VilleList);
		request.getRequestDispatcher("/hotel.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String action = request.getParameter("action");

	        if ("create".equals(action)) {
	            String nom = request.getParameter("nom");
	            String adresse = request.getParameter("adresse");
	            String telephone = request.getParameter("telephone");
	            int villeId = Integer.parseInt(request.getParameter("ville"));
				Ville ville = ejb1.findById(villeId);
	            ejb.create(new Hotel(nom,adresse,telephone,ville));

	            response.sendRedirect(request.getContextPath() + "/HotelController");
	            
	        } else if ("delete".equals(action)) {
	            int hotelId = Integer.parseInt(request.getParameter("Id"));
	            Hotel hotelToDelete = ejb.findById(hotelId);

	            if (hotelToDelete != null) {
	                boolean deleted = ejb.delete(hotelToDelete);

	                if (deleted) {
	                    System.out.println("Hotel supprimé avec succès");
	                } else {
	                    System.out.println("La suppression de l'hotel a échoué");
	                }
	            } else {
	                System.out.println("Hotel non trouvée avec l'ID : " + hotelId);
	            }

	            // Après la suppression, rediriger vers la page HotelController
	            response.sendRedirect(request.getContextPath() + "/HotelController");
	            
	        } else if (action.equals("update")) {
	            String hotel_id = request.getParameter("id");
	            Hotel hotelToUpdate = ejb.findById(Integer.parseInt(hotel_id));

	            if (hotelToUpdate != null) {
	                String updatedNom = request.getParameter("modifiedNom");
	                String updatedAdresse = request.getParameter("modifiedAdresse");
	                String updatedTelephone = request.getParameter("modifiedTelephone");
	                String updatedVilleId = request.getParameter("modifiedVille");

	                // Check for null or empty values before updating
	                if (updatedNom != null && !updatedNom.isEmpty() &&
	                    updatedAdresse != null && !updatedAdresse.isEmpty() &&
	                    updatedTelephone != null && !updatedTelephone.isEmpty() &&
	                    updatedVilleId != null && !updatedVilleId.isEmpty()) {

	                    hotelToUpdate.setNom(updatedNom);
	                    hotelToUpdate.setAdresse(updatedAdresse);
	                    hotelToUpdate.setTelephone(updatedTelephone);

	                    Ville updatedVille = ejb1.findById(Integer.parseInt(updatedVilleId));
	                    hotelToUpdate.setVille(updatedVille);

	                    ejb.update(hotelToUpdate);
                }
            }

            // Redirect to the hotel.jsp page after handling the POST request
            response.sendRedirect("HotelController");
	        

	              List<Ville> villeList = ejb1.findAll();
	              request.setAttribute("villes", villeList);

	            request.getRequestDispatcher("/hotel.jsp").forward(request, response);
	        }
	       

    }}