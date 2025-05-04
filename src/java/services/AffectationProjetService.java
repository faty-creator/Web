package services;

import dao.AffectationProjetDao; // Adjust this import based on your actual DAO package
import entities.AffectationId;
import entities.AffectationProjet; // Adjust this import based on your actual entity package
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class AffectationProjetService implements IService<AffectationProjet> {

    private final AffectationProjetDao affectationProjetDao;

    public AffectationProjetService() {
        this.affectationProjetDao = new AffectationProjetDao();
    }

    public AffectationProjetService(AffectationProjetDao affectationProjetDao) {
        this.affectationProjetDao = affectationProjetDao;
    }

    @Override
    public boolean create(AffectationProjet o) {
        return affectationProjetDao.create(o);
    }

    @Override
    public boolean delete(AffectationProjet o) {
        return affectationProjetDao.delete(o);
    }

    @Override
    public boolean update(AffectationProjet o) {
        return affectationProjetDao.update(o);
    }

    @Override
    public List<AffectationProjet> findAll() {
        return affectationProjetDao.findAll();
    }

    @Override
    public AffectationProjet findById(int id) {
        return affectationProjetDao.findById(id);
    }

   public AffectationProjet findById(int etudiantId, int projetId) {
        AffectationId affectationId = new AffectationId(etudiantId, projetId); // Création de l'objet AffectationId
        return affectationProjetDao.findById(affectationId); // Appel de la méthode du DAO
    }
    
}