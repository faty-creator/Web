/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.ProjetEtudiantDao;
import entities.ProjetEtudiant;
import java.util.List;

/**
 *
 * @author pc
 */
public class ProjetEtudiantService implements IService<ProjetEtudiant> {
    private final ProjetEtudiantDao ped = new ProjetEtudiantDao();
    @Override
    public boolean create(ProjetEtudiant o) {
        return ped.create(o);
    }

    @Override
    public boolean delete(ProjetEtudiant o) {
        return ped.delete(o);
    }

    @Override
    public boolean update(ProjetEtudiant o) {
        return ped.update(o);
    }

    @Override
    public List<ProjetEtudiant> findAll() {
    return ped.findAll();
    }

    @Override
    public ProjetEtudiant findById(int id) {
        return ped.findById(id);
    }
    
}
