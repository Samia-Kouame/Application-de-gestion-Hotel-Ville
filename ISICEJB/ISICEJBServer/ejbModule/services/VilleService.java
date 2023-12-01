package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import dao.IDaoVille;
import entities.Ville;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "kenza")
public class VilleService implements IDaoRemote<Ville>, IDaoVille {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	@PermitAll
	public Ville create(Ville o) {
		em.persist(o);
		return o;
	}

	@Override
	@PermitAll

	public boolean delete(Ville o) {
		em.remove(em.contains(o) ? o: em.merge(o));
		return true;
	}

	@Override
	@PermitAll
	public boolean update(Ville o) {
	    Ville existingVille = em.find(Ville.class, o.getId());

	    if (existingVille != null) {
	        // Mettre à jour les propriétés de l'entité existante avec les nouvelles valeurs
	        existingVille.setNom(o.getNom());
	      
	        // Ajouter d'autres propriétés à mettre à jour...

	        // Mettre à jour l'entité dans la base de données
	        em.merge(existingVille);
	    }

	    return true;
	}

	@Override
	@PermitAll
	public Ville findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Ville.class, id);
	}

	@Override
	@PermitAll
	public List<Ville> findAll() {
		Query query = em.createQuery("select v from Ville v");
		return query.getResultList();
	}

}
