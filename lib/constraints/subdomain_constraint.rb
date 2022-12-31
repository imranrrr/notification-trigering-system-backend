class SubdomainConstraints
    def matches?(request)
        Company.find_by(sub_domain: request.domain.split(".")[0])
    end
end