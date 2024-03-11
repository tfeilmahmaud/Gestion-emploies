import React, { Component } from 'react';
import { NavLink } from 'react-router-dom';

class Home extends Component {
  render() {
    return (
      <div className="container text-center mt-5">
        <h3 className="mb-4">Welcome to the Home Page</h3>
        <nav>
          <ul className="list-inline">
            <li className="list-inline-item">
              <NavLink className="btn btn-primary btn-lg me-3" to="/home">
                Home
              </NavLink>
            </li>
            <li className="list-inline-item">
              <NavLink className="btn btn-primary btn-lg me-3" to="/department">
                Department
              </NavLink>
            </li>
            <li className="list-inline-item">
              <NavLink className="btn btn-primary btn-lg" to="/employee">
                Employee
              </NavLink>
            </li>
          </ul>
        </nav>
      </div>
    );
  }
}

export default Home;
