import requests

def resolveWithAPI(domain, problem):
        data = {'domain': domain,
            'problem': problem}
        resp = requests.post('http://solver.planning.domains/solve',
                 verify=False, json=data).json()
        # return '\n'.join([act['name'] for act in resp['result']['plan']])
        try:
            return '\n'.join([act['name'] for act in resp['result']['plan']])
        except:
            try:
                 return '\n'.join([act for act in resp['result']['plan']])
            except:
                 return resp['result']['error']

prob = "2"
domain = f"problem{prob}NF/domain.pddl"
problem = f"problem{prob}NF/problem.pddl"

domain = open(domain, 'r').read()
problem = open(problem, 'r').read()
steps = resolveWithAPI(domain, problem)
print(steps)
